module "repos" {
  source = "./github/repos"
}
module "members" {
  source = "./github/members"
}
module "s3" {
  source = "./aws/s3"
}
module "roles" {
  source = "./aws/roles"
}
module "kms" {
  source = "./aws/kms"
}
module "vercel" {
  source = "./vercel"

  AWS_ACCESS_KEY_ID     = var.TF_VAR_AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.TF_VAR_AWS_SECRET_ACCESS_KEY
}
variable "TF_VAR_AWS_ACCESS_KEY_ID" {}
variable "TF_VAR_AWS_SECRET_ACCESS_KEY" {}
