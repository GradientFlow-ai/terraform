# Add repository
resource "github_repository" "terraform" {
  name        = "terraform"
  description = "IaC for GradientFlow"
  visibility  = "public"

  topics = ["terraform", "iac", "embeddings"]

  allow_merge_commit = true
  allow_rebase_merge = false
  allow_squash_merge = false
  auto_init          = false
  has_projects       = true
  has_issues         = true
  has_wiki           = true

  gitignore_template = "Terraform"
  license_template   = "mit"
}

# Configure branch protection for the repository
resource "github_branch_protection" "terraform" {
  repository_id  = github_repository.terraform.name
  pattern        = "main"
  enforce_admins = true

  # We are using GH actions, provide action names as list of strings
  required_status_checks {
    strict   = false
    contexts = ["Validate terraform", "Check file formatting", "Create terraform plan"]
  }

  # A new commit requires fresh approval
  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    pull_request_bypassers = ["/coyotespike"] # until we have more reviewers :)
  }
}

# These are the only secrets we must set by hand.
# They enable terraform to fetch all the others from AWS Secrets Manager
resource "github_actions_secret" "secrets_manager_id" {
  repository  = "terraform"
  secret_name = "AWS_MANAGER_ID"
}

resource "github_actions_secret" "secrets_manager_key" {
  repository  = "terraform"
  secret_name = "AWS_MANAGER_KEY"
}

resource "github_actions_secret" "super_github_token" {
  repository  = "terraform"
  secret_name = "SUPER_GITHUB_TOKEN"
}
