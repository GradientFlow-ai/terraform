resource "vercel_project" "eaas" {
  name      = "vercel-project-eaas"
  framework = "nextjs"

  git_repository = {
    type = "github"
    repo = "GradientFlow-ai/eaas"
  }
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

resource "vercel_project_environment_variable" "aws_access_key_id" {
  project_id = vercel_project.eaas.id
  key        = "AWS_ACCESS_KEY_ID"
  value      = var.AWS_ACCESS_KEY_ID
  target     = ["production"]
}

resource "vercel_project_environment_variable" "aws_secret_access_key" {
  project_id = vercel_project.eaas.id
  key        = "AWS_SECRET_ACCESS_KEY"
  value      = var.AWS_SECRET_ACCESS_KEY
  target     = ["production"]
}

resource "vercel_project_environment_variable" "test_key" {
  project_id = vercel_project.eaas.id
  key        = "TEST_DUMMY_KEY"
  value      = "hello-world"
  target     = ["production"]
}
