# Action for Publishing Figshare Article
This action will publish an article if it is ready to be published by extracting the `ID` from previously generated `figshare_create_resp.json` or `ID` from `FIGSHARE_ARTICLE_ID` environment variable.
`FIGSHARE_ARTICLE_ID` will override the ID from `figshare_create_resp.json`.

## Usage
If there is an unpublished article created through `create` workflow, it would publish the article by reading the `ID` from `figshare_create_resp.json`.
If you want to publish any other article, set the Environment variable `FIGSHARE_ARTICLE_ID` to the ID of article you want to publish. 

```hcl
workflow "Publish Article" {
  resolves = "publish"
}
action "publish" {
  uses = "./publish"
  secrets = [ "FIGSHARE_API_TOKEN" ]
  env = {
    FIGSHARE_ARTICLE_ID = ""
  }
}
```

## Secrets
* `FIGSHARE_API_TOKEN` - **Required** The API access_token for figshare account.

## Environment variables
* `FIGSHARE_ARTICLE_ID` - **Optional** ID of the article to be published. **Required** if no article ever created using `create`.

