workflow "Create Figshare Article" {
  resolves = "create"
}
action "create" {
  uses = "./create"
  secrets = ["FIGSHARE_API_TOKEN"]
  env = {
    FIGSHARE_METADATA_PATH = ".ci/metadata.json"
  }
}