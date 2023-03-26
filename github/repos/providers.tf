# this must be included in each submodule or you will get horrible and strange errors
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}


