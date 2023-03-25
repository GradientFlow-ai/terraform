# Add repository
resource "github_repository" "terraform" {
  name        = "terraform"
  description = "IaC for GradientFlow"
  visibility  = "public"

  topics      = ["terraform", "iac", "embeddings"]

  allow_merge_commit = true
  allow_rebase_merge = false
  allow_squash_merge = false

  gitignore_template = "Terraform"
  license_template   = "mit"
}

# Configure branch protection for the repository
resource "github_branch_protection" "terraform" {
  repository_id     = github_repository.terraform.name
  pattern           = "main"
  enforce_admins    = true

  # We are using GH actions, provide action names as list of strings
  required_status_checks {
    strict   = false
    contexts = ["Terraform validate"]
  }

  # A new commit requires fresh approval
  required_pull_request_reviews {
    dismiss_stale_reviews = true
  }
}
