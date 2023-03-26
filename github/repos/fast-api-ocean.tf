resource "github_repository" "fast-api-ocean" {
  name        = "fast-api-ocean"
  description = "Docker-based visualizations api running on DigitalOcean"

  topics = ["digitalocean", "visualizations", "embeddings"]

  allow_merge_commit = true
  allow_rebase_merge = false
  allow_squash_merge = false
  auto_init          = false
  has_projects       = true
  has_issues         = true
}


# Configure branch protection for the repository
resource "github_branch_protection" "fast-api-ocean" {
  repository_id  = github_repository.fast-api-ocean.name
  pattern        = "main"
  enforce_admins = true

  # we will turn these on later
  # We are using GH actions, provide action names as list of strings
  # required_status_checks {
  #   strict   = false
  #   contexts = ["Validate terraform", "Check file formatting"]
  # }

  # A new commit requires fresh approval
  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    pull_request_bypassers = ["/coyotespike"] # until we have more reviewers :)
  }
}
