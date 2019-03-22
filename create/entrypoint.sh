#!/usr/bin/env sh
set -ex
BASE_URL="https://api.figshare.com/v2/account/articles"
curl --header "Content-Type: application/json" \
      --request POST \
      --data @$FIGSHARE_METADATA_PATH \
      $BASE_URL?access_token=$FIGSHARE_API_TOKEN \
      -o $GITHUB_WORKSPACE/figshare_create_resp.json
