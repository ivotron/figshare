workflow "Upload Files" {
  resolves = "upload"
}
action "upload" {
  uses = "./upload"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_ARTICLE_ID = "7873919"
    FIGSHARE_UPLOAD_PATH = "./files"
  }
}