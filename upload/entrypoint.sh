#!/usr/bin/env bash

set -e
BASE_URL='https://api.figshare.com/v2/account/articles'
if [[ -e "$GITHUB_WORKSPACE/figshare_create_resp.json" ]] && [[ -z "$FIGSHARE_ARTICLE_ID" ]];
then
    LOCATION_URL=$(jq -r '.location' $GITHUB_WORKSPACE/figshare_create_resp.json)
    export FIGSHARE_ARTICLE_ID=$(echo ${LOCATION_URL##*/})
    echo $FIGSHARE_ARTICLE_ID
else
    echo "No Article ID found"
    exit 1
fi
if [ -z $FIGSHARE_UPLOAD_PATH ]; then
  echo "Expecting FIGSHARE_UPLOAD_PATH variable"
  exit 1
fi
if [ ! -d "$GITHUB_WORKSPACE/$FIGSHARE_UPLOAD_PATH" ]; then
  echo "Expecting $FIGSHARE_UPLOAD_PATH at $GITHUB_WORKSPACE"
  exit 1
fi
if [ ! "$(ls -A "$GITHUB_WORKSPACE/$FIGSHARE_UPLOAD_PATH")" ]; then
  echo "No files in $GITHUB_WORKSPACE/$FIGSHARE_UPLOAD_PATH"
  exit 1
fi

for file in "$FIGSHARE_UPLOAD_PATH"/*; do
    echo "$file"
    MD5=($(md5sum "$file"))
    FILE_SIZE=$(stat -c%s "$file")
    echo $FILE_SIZE
    RESPONSE=$(curl -sf -H "Content-Type: application/json"  -H 'Authorization: token '$FIGSHARE_API_TOKEN \
         -d '{"name":"'"$(basename "$file")"'","md5":"'$MD5'","size":'$FILE_SIZE'}' \
         "$BASE_URL/$FIGSHARE_ARTICLE_ID/files")
    FILE_ID=$(echo "$RESPONSE" | sed -r "s/.*\/([0-9]+).*/\1/")
    echo 'The file id is: '$FILE_ID
    RESPONSE=$(curl -s -f -H 'Authorization: token '$FIGSHARE_API_TOKEN -X GET "$BASE_URL/$FIGSHARE_ARTICLE_ID/files/$FILE_ID")
    UPLOAD_URL=$(echo "$RESPONSE" | sed -r 's/.*"upload_url":\s"([^"]+)".*/\1/')
    echo 'The upload URL is: '$UPLOAD_URL
    RESPONSE=$(curl -s -f -H 'Authorization: token '$FIGSHARE_API_TOKEN -X GET "$UPLOAD_URL")
    echo $RESPONSE
    PARTS_SIZE=$(echo "$RESPONSE" | sed -r 's/"endOffset":([0-9]+).*/\1/' | sed -r 's/.*,([0-9]+)/\1/')
    PARTS_SIZE=$(($PARTS_SIZE+1))
    echo 'The part value is: '$PARTS_SIZE
    echo 'Spliting the provided item into parts process had begun...'
    mkdir temp && split -b$PARTS_SIZE "$file" "$GITHUB_WORKSPACE/temp/part_"
    echo 'Process completed!'
    MAX_PART=$((($FILE_SIZE+$PARTS_SIZE-1)/$PARTS_SIZE))
    echo 'The number of parts is: '$MAX_PART
    echo 'Perform the PUT operation of parts...'
    i=1
    for f in $GITHUB_WORKSPACE/temp/*; do
        echo $f $i
        RESPONSE=$(curl -s -f -H 'Authorization: token '$FIGSHARE_API_TOKEN -X PUT "$UPLOAD_URL/$i" --data-binary @$f)
        i=$((i+1))
    done
    echo 'Completing the file upload...'
    RESPONSE=$(curl -s -f -H 'Authorization: token '$FIGSHARE_API_TOKEN -X POST "$BASE_URL/$FIGSHARE_ARTICLE_ID/files/$FILE_ID")
    echo 'Done!'
    rm -rf $GITHUB_WORKSPACE/temp/
done
