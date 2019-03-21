# Action for Creating Figshare-Article
This action creates an article with the metadata provided in `metadata.json` file.

## Usage
To create an article, add the metadata to `metadata.json` file. Assign the path to `metadata.json` file to `FIGSHARE_METADATA_PATH` environment variable. 

```hcl
workflow "Create Figshare Article" {
  resolves = "create"
}
action "create" {
  uses = "popperized/figshare/create@master"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_METADATA_PATH = "./ci/metadata.json"
  }
}
```
Example `metadata.json` file
```json
{
  "title": "Test article title",
  "description": "Test description of article"
}
```
This action will output the response from Figshare to `create_resp.json`

## Secrets
* `FIGSHARE_API_TOKEN` - **Required** The API access_token for Figshare account.

## Environment variables
* `FIGSHARE_METADATA_PATH` - **Required** Path to `metadata.json` file.

