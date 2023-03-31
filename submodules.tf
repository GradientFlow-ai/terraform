module "repos" {
  source = "./github/repos"
}
module "members" {
  source = "./github/members"
}
module "s3" {
  source = "./aws/s3"
}
