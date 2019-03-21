workflow "Download" {
  resolves = "download"
}
action "download" {
  uses = "./download"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_ARTICLE_ID = "6865523"
    FIGSHARE_OUTPUT_DIR_PATH = "./data"
  }
}