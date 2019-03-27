#!/usr/bin/env sh
set -ex
BASE_URL="https://api.figshare.com/v2/account/articles"

if [[ -e "$GITHUB_WORKSPACE/figshare_create_resp.json" ]] && [[ -z "$FIGSHARE_ARTICLE_ID" ]];
then
    LOCATION_URL=$(jq -r '.location' $GITHUB_WORKSPACE/figshare_create_resp.json)
    export FIGSHARE_ARTICLE_ID=$(echo ${LOCATION_URL##*/})
    echo $FIGSHARE_ARTICLE_ID
fi
curl -X POST -H 'Authorization: token '$FIGSHARE_API_TOKEN "$BASE_URL/$FIGSHARE_ARTICLE_ID/publish"