resource "aws_iam_role" "secrets_manager_role" {
  name = "secrets_manager_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_user.gh_runner.arn
        }
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name_prefix = "secrets_manager_policy_"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets",
          "secretsmanager:CreateSecret",
          "secretsmanager:UpdateSecret",
          "secretsmanager:DeleteSecret",
          "secretsmanager:TagResource",
          "secretsmanager:UntagResource"
        ]
        Resource = "*"
      }
    ]
  })
}
