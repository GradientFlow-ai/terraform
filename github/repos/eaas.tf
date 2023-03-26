resource "github_repository" "eaas" {
  name        = "eaas"
  description = "NextJS-based frontend"

  topics = ["nextjs", "vercel", "embeddings"]

  allow_merge_commit = true
  allow_rebase_merge = false
  allow_squash_merge = false
  auto_init          = false
  has_wiki           = true
  has_projects       = true
  has_issues         = true
}


# Configure branch protection for the repository
resource "github_branch_protection" "eaas" {
  repository_id  = github_repository.eaas.name
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
