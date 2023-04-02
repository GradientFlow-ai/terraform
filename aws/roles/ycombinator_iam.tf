resource "aws_iam_role" "create_roles" {
  name = "create_roles"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_user.gh_runner.arn
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "create_roles_policy" {
  name = "create_roles_policy"
  role = aws_iam_role.create_roles.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:CreateRole",
          "iam:PutRolePolicy",
          "iam:PassRole"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
