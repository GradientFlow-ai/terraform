# Infrastructure Management

## Usage

You will need to set `GITHUB_TOKEN` and `GITHUB_OWNER` in your environment, after creating a personal access token on GitHub.

These should be set as local variables - but still pulled from the environment - to improve visibility but [there is a bug](https://github.com/integrations/terraform-provider-github/issues/1592).

## Gotchas

provider "github" {} must be absolutely empty to prevent authentication errors.
Check terraform -version to ensure only one provider is used, integrations/github, not hashicorp/github

After importing a resource, I had to manually place "module" in tfstate. Otherwise terraform still wanted to destroy the resource it had just imported and then attempt to create the repo again (github will block because it already exists).

terraform import -config=github/repos github_repository.eaas eaas

the -config is important, else terraform cannot find the child repos.
