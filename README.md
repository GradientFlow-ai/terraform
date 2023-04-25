# Infrastructure Management

## Github Actions

We run and apply Terraform plans via GitHub Actions. This creates a consistent development environment and promotes reproducibility and transparency.

On PR creation, Terraform will check formatting, validate, and then leave a comment with the output of `terraform plan`. The plan is then applied by commenting `terraform apply` on the PR.

Note there is a bug where `githhub_branch_protection` always shows resources as changed. These "changes" can be disregarded.

## Usage

You will need to set `GITHUB_TOKEN` and `GITHUB_OWNER` in your environment, after creating a personal access token on GitHub.

These should be set as local variables - but still pulled from the environment - to improve visibility but [there is a bug](https://github.com/integrations/terraform-provider-github/issues/1592).

## Environmental Variables and Secrets

We only need to set a few environmental variables in this repo on GitHub. We have to set AWS access keys, because those are used by the runners before they can decrypt all the other secrets using the last env var we must set manually.

This last variable, a private GPG key, encrypts and decrypts the secrets files, which are `secrets.auto.tfvars` and the `tfstate` file. All other secrets are assigned to repos and to platforms like Vercel via Terraform (that is, through this repo), from the `tfvars` file.

We are able to commit this file to git because it and the state file are encrypted. You can find the details about how to do this in the wiki. If you need to add or change these secrets, though, you'll need that private key so that git will decrypt the files for you locally. If you just need to add repos or make other environmental changes, you won't need it.

If you need the key, just contact one of the keyholders and we'll share it with you via a secure time-limited link (1Password and other apps provide this nifty service). In the future we'll make a shared secrets manager; we should be able to manage access and permissions through Terraform.

### Why and Wherefore

You should manage secrets via Terraform. As said above, you can set all GitHub repo secrets through Terraform, as well as Vercel secrets and so on.
As of April 2023, when the project is young, we have about 15 env vars to manage, in 3 different locations. That is already a lot! We want to document this in code and we want to avoid setting them manually, just like the rest of our infrastructure.

However, if you assign any secret via Terraform, Terraform will save the secret in the tfstate file. There is absolutely no way around this, regardless of where you pass the secret in from or how you pass it in. For this reason, the tfstate and tfvars files must either never be committed to git and stored in some other secure location, or they must be encrypted before committing them.

This isn't theoretical. Bad guys use automated tools to scan GitHub and will immediately rack up tens of thousands of dollars of charges on AWS and other locations. For this reason, the good guys (AWS and GitHub) also automatically scan GitHub, and AWS will shut down your account immediately if they detect you have exposed a secret. This is a massive pain even if the bad guys don't getcha.

Don't be scared, we already encrypt everything and we have GitGuardian scanning our repos. Just to give you background.

## ClickOps

- env vars in GH
- same in vercel
- Still gotta fetch IAM user keys from AWS and put them in the above two places.

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

### Why It's So Hard

You might be used to permissions and access like GitHub: you get an API token that allows you to do stuff programmatically. Maybe, if you're fancy, a fine-grained API token.

AWS is designed for enterprise, so it is a little more complicated. First, you define a role. Second, you define a policy which grants certain permissions to the role. Third, you create a user which assumes the role, and this user has an access ID and an access key, which allows you to do stuff programmatically.

This allows you to define arbitrarily many overlapping roles which may inherit from multiple policies, and have many users which assume one or many roles.

As always, the goal is to contain the fallout from keys leaking. Even people who are smart and conscientious can get hacked or phished, and sometimes bad guys infiltrate from like three cloud services away, toppling them like dominoes.
