resource "aws_iam_user" "vercel_s3_user" {
  name = "VercelS3User1"
}

resource "aws_iam_access_key" "vercel_s3_user_key" {
  user = aws_iam_user.vercel_s3_user.name
}

resource "aws_iam_policy" "vercel_s3_policy" {
  name        = "VercelS3Policy"
  description = "Policy for Vercel to create pre-signed URLs for S3 access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.S3_BUCKET_NAME}",
          "arn:aws:s3:::${var.S3_BUCKET_NAME}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "vercel_s3_policy_attachment" {
  policy_arn = aws_iam_policy.vercel_s3_policy.arn
  user       = aws_iam_user.vercel_s3_user.name
}

output "vercel_s3_user_access_key" {
  value     = aws_iam_access_key.vercel_s3_user_key.id
  sensitive = true
}

output "vercel_s3_user_secret_key" {
  value     = aws_iam_access_key.vercel_s3_user_key.secret
  sensitive = true
}

variable "S3_BUCKET_NAME" {
  description = "The name of the S3 bucket, from the secrets file"
  type        = string
}
