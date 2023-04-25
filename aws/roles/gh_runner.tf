resource "aws_iam_user" "gh_runner" {
  name = "gh_runner"
}

resource "aws_iam_user_policy" "gh_runner_policy" {
  name = "gh_runner_policy"
  user = aws_iam_user.gh_runner.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ],
        Effect   = "Allow",
        Resource = aws_iam_role.s3.arn
        Resource = aws_iam_role.create_roles.arn
        Resource = aws_iam_role.secrets_manager_role.arn
      }
    ]
  })
}
