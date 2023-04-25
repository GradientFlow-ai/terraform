module "repos" {
  source = "./github/repos"

  DATABASE_URL        = var.DATABASE_URL
  SHADOW_DATABASE_URL = var.SHADOW_DATABASE_URL
  SUPER_GITHUB_TOKEN  = var.SUPER_GITHUB_TOKEN
}
module "members" {
  source = "./github/members"
}
module "s3" {
  source = "./aws/s3"
}
module "roles" {
  source         = "./aws/roles"
  S3_BUCKET_NAME = var.S3_BUCKET_NAME
}
module "vercel" {
  source = "./vercel"

  s3_user_access_key_id     = module.roles.vercel_s3_user_access_key
  s3_user_secret_access_key = module.roles.vercel_s3_user_secret_key

  S3_BUCKET_NAME       = var.S3_BUCKET_NAME
  GITHUB_ID            = var.GITHUB_ID
  GITHUB_SECRET        = var.GITHUB_SECRET
  GOOGLE_CLIENT_ID     = var.GOOGLE_CLIENT_ID
  GOOGLE_CLIENT_SECRET = var.GOOGLE_CLIENT_SECRET
  NEXTAUTH_URL         = var.NEXTAUTH_URL
}
