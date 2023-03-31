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
module "vercel" {
  source = "./vercel"
}
