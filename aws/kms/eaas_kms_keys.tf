resource "aws_secretsmanager_secret" "DATABASE_URL" {
  name        = "DATABASE_URL"
  description = "Allows eaas to access Supabase postgres"
}
resource "aws_secretsmanager_secret" "SHADOW_DATABASE_URL" {
  name        = "SHADOW_DATABASE_URL"
  description = "Allows eaas to access Prisma postgres shadow on Supabase"
}

resource "aws_secretsmanager_secret" "S3_BUCKET_NAME" {
  name        = "S3_BUCKET_NAME"
  description = "Tells eaas where to store documents on S3"
}
resource "aws_secretsmanager_secret" "AWS_ACCESS_KEY_ID" {
  name        = "AWS_ACCESS_KEY_ID"
  description = "Gives eaas permission to store documents on S3"
}
resource "aws_secretsmanager_secret" "AWS_SECRET_ACCESS_KEY" {
  name        = "AWS_SECRET_ACCESS_KEY"
  description = "Gives eaas permission to store documents on S3"
}
