module "repos" {
  source = "./github/repos"

  DATABASE_URL                 = var.DATABASE_URL
  SHADOW_DATABASE_URL          = var.SHADOW_DATABASE_URL
  TF_VAR_AWS_ACCESS_KEY_ID     = var.TF_VAR_AWS_ACCESS_KEY_ID
  TF_VAR_AWS_SECRET_ACCESS_KEY = var.TF_VAR_AWS_SECRET_ACCESS_KEY
  SUPER_GITHUB_TOKEN           = var.SUPER_GITHUB_TOKEN
  VERCEL_API_TOKEN             = var.VERCEL_API_TOKEN
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

  S3_BUCKET_NAME        = var.S3_BUCKET_NAME
  AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  GITHUB_ID             = var.GITHUB_ID
  GITHUB_SECRET         = var.GITHUB_SECRET
  GOOGLE_CLIENT_ID      = var.GOOGLE_CLIENT_ID
  GOOGLE_CLIENT_SECRET  = var.GOOGLE_CLIENT_SECRET
  NEXTAUTH_URL          = var.NEXTAUTH_URL
}
