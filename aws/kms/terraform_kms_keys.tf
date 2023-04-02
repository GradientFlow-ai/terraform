resource "aws_secretsmanager_secret" "TF_VAR_AWS_ACCESS_KEY_ID" {
  name        = "TF_VAR_AWS_ACCESS_KEY_ID"
  description = "Allows Terraform to manage S3. Created in roles/s3_iam"
}
resource "aws_secretsmanager_secret" "TF_VAR_AWS_SECRET_ACCESS_KEY" {
  name        = "TF_VAR_AWS_SECRET_ACCESS_KEY"
  description = "Allows Terraform to manage S3. Created in roles/s3_iam"
}
resource "aws_secretsmanager_secret" "SUPER_GITHUB_TOKEN" {
  name        = "SUPER_GITHUB_TOKEN"
  description = "A second token necessary for Github Actions terraform plan and apply in Terraform repo"
}
