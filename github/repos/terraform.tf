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
resource "github_actions_secret" "tf_var_aws_access_key_id" {
  repository      = "terraform"
  secret_name     = "TF_VAR_AWS_ACCESS_KEY_ID"
  plaintext_value = var.TF_VAR_AWS_ACCESS_KEY_ID
}
resource "github_actions_secret" "tf_var_aws_secret_access_key" {
  repository      = "terraform"
  secret_name     = "TF_VAR_AWS_SECRET_ACCESS_KEY"
  plaintext_value = var.TF_VAR_AWS_SECRET_ACCESS_KEY
}
resource "github_actions_secret" "vercel_api_token" {
  repository      = "terraform"
  secret_name     = "VERCEL_API_TOKEN"
  plaintext_value = var.VERCEL_API_TOKEN
}


variable "TF_VAR_AWS_ACCESS_KEY_ID" {
  type        = string
  description = "Allows Terraform to manage S3. Created in roles/s3_iam"
  default     = "secret"
  sensitive   = true
}
variable "TF_VAR_AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "Allows Terraform to manage S3. Created in roles/s3_iam"
  default     = "secret"
  sensitive   = true
}
variable "SUPER_GITHUB_TOKEN" {
  type        = string
  description = "A second token necessary for Github Actions terraform plan and apply in Terraform repo"
  default     = "secret"
  sensitive   = true
}
variable "VERCEL_API_TOKEN" {
  type        = string
  description = "Allows Terraform's Vercel provider to manage Vercel projects"
  default     = "secret"
  sensitive   = true
}
