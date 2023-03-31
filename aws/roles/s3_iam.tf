resource "aws_iam_role" "example" {
  name               = "example_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::your-account-id:root"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "example" {
  name   = "example_policy"
  role   = aws_iam_role.example.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
