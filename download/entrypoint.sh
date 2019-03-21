#!/usr/bin/env sh
[[ -d $FIGSHARE_OUTPUT_DIR_PATH ]] || mkdir "$FIGSHARE_OUTPUT_DIR_PATH"
curl -X GET "https://api.figshare.com/v2/articles/$FIGSHARE_ARTICLE_ID/files"| jq -c '.[]' | while read i; do
    curl -Lo "$GITHUB_WORKSPACE/"$FIGSHARE_OUTPUT_DIR_PATH"/$(echo $i | jq -r '.name')" "https://api.figshare.com/v2/file/download/$(echo $i | jq -r '.id')?access_token=$FIGSHARE_API_TOKEN"
done