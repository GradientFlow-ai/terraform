# Infrastructure Management

## Usage

You will need to set `GITHUB_TOKEN` and `GITHUB_OWNER` in your environment, after creating a personal access token on GitHub.

These should be set as local variables - but still pulled from the environment - to improve visibility but [there is a bug](https://github.com/integrations/terraform-provider-github/issues/1592).

## Github Actions

We now run and apply Terraform plans via GitHub Actions. This creates a consistent development environment and promotes reproducibility and transparency.

On PR creation, Terraform will check formatting, validate, and then leave a comment with the output of `terraform plan`. The plan is then applied by commenting `terraform apply` on the PR.

Note there is a bug where `githhub_branch_protection` always shows resources as changed. These can be disregarded.

## Organization

Whenever you add a subfolder, you must add to `submodules.tf`. Otherwise, when you turn terraform commands from the root, terraform will not find your submodule.

Also, add new providers to the root `providers.tf`, not in the leaf folders.

## Github

provider "github" {} must be absolutely empty to prevent authentication errors.
Check terraform -version to ensure only one provider is used, integrations/github, not hashicorp/github

After importing a resource, I had to manually place "module" in tfstate. Otherwise terraform still wanted to destroy the resource it had just imported and then attempt to create the repo again (github will block because it already exists).

terraform import -config=github/repos github_repository.eaas eaas

the -config is important, else terraform cannot find the child repos.

See [this comment](https://github.com/integrations/terraform-provider-github/issues/647#issuecomment-1484185403) for more.

### Plan

Terraform plan required not only the github token automatically assigned by GitHub during a run (`secrets.GITHUB_TOKEN`), but a separate permissions token similar to that used locally.

## AWS

Again, a painful process. To securely execute Terraform plans which update AWS, via GitHub Runners, we must create a user with permissions to affect (e.g.) S3. Then the GitHub Runner assumes this role.

We must create a role with a policy, then a user with a policy to assume that role. Also, we must enable OIDC for GitHub to work with AWS (this was a missing step).

Or so I think, the workflow yml file does not use those credentials. It seems to use only the OIDC credentials magically working somewhere.

At this time I don't know how many buckets we will create or how it will be organized.
