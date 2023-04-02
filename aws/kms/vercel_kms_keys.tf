resource "aws_secretsmanager_secret" "VERCEL_API_KEY" {
  name        = "VERCEL_API_KEY"
  description = "Allows Terraform to manage Vercel projects"
}
resource "aws_secretsmanager_secret" "GITHUB_ID" {
  name        = "GITHUB_ID"
  description = "Enables Vercel to use GitHub as OAuth provider"
}
resource "aws_secretsmanager_secret" "GITHUB_SECRET" {
  name        = "GITHUB_SECRET"
  description = "Enables Vercel to use GitHub as OAuth provider"
}
resource "aws_secretsmanager_secret" "GOOGLE_CLIENT_ID" {
  name        = "GOOGLE_CLIENT_ID"
  description = "Enables Vercel to use Google as OAuth provider"
}
resource "aws_secretsmanager_secret" "GOOGLE_CLIENT_SECRET" {
  name        = "GOOGLE_CLIENT_SECRET"
  description = "Enables Vercel to use Google as OAuth provider"
}
