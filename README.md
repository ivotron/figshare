# Figshare

**GitHub Actions for Figshare.**

## Publish an article on Figshare
To publish an article at [Figshare](https://figshare.com/). See the below example.

```hcl
workflow "Create DOI" {
  resolves = "publish"
}

action "create" {
  uses = "popperized/figshare/create@master"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_METADATA_PATH = "./metadata.json"
  }
}

action "upload" {
  needs="create"
  uses = "popperized/figshare/upload@master"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_UPLOAD_PATH = "./files"
  }
}

action "publish" {
  needs="upload"
  uses = "popperized/figshare/publish@master"
  secrets = [ "FIGSHARE_API_TOKEN" ]
}
```
Example `metadata.json` file

```json
{
  "title": "Article title",
  "description": "description of article",
  "keywords": [
    "tag1",
    "tag2"
  ],
  "categories": [
    1,
    10,
    11
  ],
  "license": 1
}
```


### Usage

Keep the metadata in a `json` file and set the path to this `json` file as `FIGSHARE_METADATA_PATH` environment variable.
Put the files to be uploaded in a directory and set the path to this directory as `FIGSHARE_UPLOAD_PATH` environment variable.
It would create an article with the provided metadata and upload the files in `FIGSHARE_UPLOAD_PATH` directory and publishes the article.


### Secrets

* `FIGSHARE_API_TOKEN` - **Required** The API access_token for figshare account.


### Environment variables

* `FIGSHARE_METADATA_PATH` - **Required** Path to `json` file containing metadata.
* `FIGSHARE_UPLOAD_PATH` - **Required** path to directory containing the files to be uploaded.
