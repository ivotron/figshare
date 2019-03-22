# Action for Zenodo-files-download
This action will download files from an article.

## Usage

```hcl
workflow "Download" {
  resolves = "download"
}
action "download" {
  uses = "popperized/figshare/download@master"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_ARTICLE_ID = "6865523"
    FIGSHARE_OUTPUT_PATH = "./data"
  }
}
```
## Secrets
* `FIGSHARE_API_TOKEN` - **Required** The API access_token for Figshare account.

## Environment variables
* `FIGSHARE_ARTICLE_ID` - **Required** ID of the article from which files have to be downloaded.
* `FIGSHARE_OUTPUT_PATH`- **Required** Path to the output directory.
