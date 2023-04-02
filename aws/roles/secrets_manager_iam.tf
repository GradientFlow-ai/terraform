resource "aws_iam_user" "secrets_manager_user" {
  name = "secrets_manager_user"
}

resource "aws_iam_access_key" "secrets_manager_user_key" {
  user = aws_iam_user.secrets_manager_user.name
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
          "secretsmanager:ListSecrets"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "secrets_manager_policy_attachment" {
  name       = "secrets_manager_policy_attachment"
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
  users      = [aws_iam_user.secrets_manager_user.name]
}
