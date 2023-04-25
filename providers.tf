terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.4"
    }
  }
}

provider "github" {}

# Configure the AWS Provider
provider "aws" {
  region     = "us-west-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "oidc_github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.3.1"

  github_repositories = [
    "GradientFlow-ai/terraform",
  ]
}

provider "vercel" {
  api_token = var.TF_VAR_VERCEL_API_TOKEN
  team      = "team_mllS6R4z5VZ2JecC9ZnMxi5g"
}
