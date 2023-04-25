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
    contexts = ["Validate terraform", "Check file formatting", "Create terraform plan", "GitGuardian Security Checks"]
  }

  # A new commit requires fresh approval
  required_pull_request_reviews {
    dismiss_stale_reviews  = true
    pull_request_bypassers = ["/coyotespike"] # until we have more reviewers :)
  }
}

resource "github_actions_secret" "super_github_token" {
  repository      = "terraform"
  secret_name     = "SUPER_GITHUB_TOKEN"
  plaintext_value = var.SUPER_GITHUB_TOKEN
}
resource "github_actions_secret" "tf_var_aws_account_id" {
  repository      = "terraform"
  secret_name     = "AWS_ACCOUNT_ID"
  plaintext_value = var.TF_VAR_AWS_ACCOUNT_ID
}

## The below is duplicated from root/variables.tf
variable "TF_VAR_AWS_ACCOUNT_ID" {
  type        = string
  description = "Allows GitHub runner to authenticate with AWS. Role created manually on AWS."
  default     = "secret"
  sensitive   = true
}
variable "SUPER_GITHUB_TOKEN" {
  type        = string
  description = "A second token necessary for Github Actions terraform plan and apply in Terraform repo"
  default     = "secret"
  sensitive   = true
}
