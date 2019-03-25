# Action for Figshare-upload
This action will upload files to an existing article.

## Usage
Put the files you want to upload in a directory and set the path to this directory as `FIGSHARE_UPLOAD_PATH` environment variable.

```hcl
workflow "Upload Files" {
  resolves = "upload"
}
action "upload" {
  uses = "./upload"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_ARTICLE_ID = ""
    FIGSHARE_UPLOAD_PATH = "./files"
  }
}
```
It would push the files to recently created article created by `create` or you can set the article ID in the environment variable.
Here the files in `/files` directory will be uploaded.
## Secrets
* `FIGSHARE_API_TOKEN` - **Required** The API access_token for figshare account.

## Environment variables
* `FIGSHARE_UPLOAD_PATH` - **Required** path to directory containing the files to be uploaded.
* `FIGSHARE_ARTICLE_ID` - **Optional** ID of the article to which the files are to be uploaded. **Required** if no article ever created using `create`.

