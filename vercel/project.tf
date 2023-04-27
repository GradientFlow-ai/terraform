resource "vercel_project" "eaas" {
  name      = "eaas"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = "GradientFlow-ai/eaas"
  }
}

# These lines allow the parent module to pass in the root variables
variable "S3_BUCKET_NAME" {}
variable "S3_BUCKET_REGION" {}
variable "GITHUB_ID" {}
variable "GITHUB_SECRET" {}
variable "GOOGLE_CLIENT_ID" {}
variable "GOOGLE_CLIENT_SECRET" {}
variable "NEXTAUTH_URL" {}
variable "s3_user_access_key_id" {
  type        = string
  description = "S3 user access key ID for Vercel"
}
variable "s3_user_secret_access_key" {
  type        = string
  description = "S3 user secret access key for Vercel"
}

resource "vercel_project_environment_variable" "AWS_ACCESS_KEY_ID" {
  project_id = vercel_project.eaas.id
  key        = "AWS_ACCESS_KEY_ID"
  value      = var.s3_user_access_key_id
  target     = ["production"]
}

resource "vercel_project_environment_variable" "AWS_SECRET_ACCESS_KEY" {
  project_id = vercel_project.eaas.id
  key        = "AWS_SECRET_ACCESS_KEY"
  value      = var.s3_user_secret_access_key
  target     = ["production"]
}
resource "vercel_project_environment_variable" "S3_BUCKET_NAME" {
  project_id = vercel_project.eaas.id
  key        = "S3_BUCKET_NAME"
  value      = var.S3_BUCKET_NAME
  target     = ["production"]
}
resource "vercel_project_environment_variable" "S3_BUCKET_REGION" {
  project_id = vercel_project.eaas.id
  key        = "AWS_REGION"
  value      = var.S3_BUCKET_REGION
  target     = ["production"]
}
resource "vercel_project_environment_variable" "GITHUB_ID" {
  project_id = vercel_project.eaas.id
  key        = "GITHUB_ID"
  value      = var.GITHUB_ID
  target     = ["production"]
}
resource "vercel_project_environment_variable" "GITHUB_SECRET" {
  project_id = vercel_project.eaas.id
  key        = "GITHUB_SECRET"
  value      = var.GITHUB_SECRET
  target     = ["production"]
}
resource "vercel_project_environment_variable" "GOOGLE_CLIENT_ID" {
  project_id = vercel_project.eaas.id
  key        = "GOOGLE_CLIENT_ID"
  value      = var.GOOGLE_CLIENT_ID
  target     = ["production"]
}
resource "vercel_project_environment_variable" "GOOGLE_CLIENT_SECRET" {
  project_id = vercel_project.eaas.id
  key        = "GOOGLE_CLIENT_SECRET"
  value      = var.GOOGLE_CLIENT_SECRET
  target     = ["production"]
}
resource "vercel_project_environment_variable" "NEXTAUTH_URL" {
  project_id = vercel_project.eaas.id
  key        = "NEXTAUTH_URL"
  value      = var.NEXTAUTH_URL
  target     = ["production"]
}
