resource "aws_iam_user" "admin_user" {
  name = "new_admin_user"
}

resource "aws_iam_access_key" "admin_user" {
  user = aws_iam_user.admin_user.name
}

resource "aws_iam_user_policy" "admin_user_policy" {
  name = "new_admin_user_policy"
  user = aws_iam_user.admin_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:AddUserToGroup",
          "iam:AttachRolePolicy",
          "iam:AttachUserPolicy",
          "iam:CreateAccessKey",
          "iam:CreateRole",
          "iam:CreateUser",
          "iam:DeleteRole",
          "iam:DeleteRolePolicy",
          "iam:DeletePolicy",
          "iam:DeleteUser",
          "iam:DeleteUserPolicy",
          "iam:DetachRolePolicy",
          "iam:DetachUserPolicy",
          "iam:Get*",
          "iam:List*",
          "iam:PassRole",
          "iam:PutRolePolicy",
          "iam:PutUserPolicy",
          "iam:RemoveUserFromGroup",
          "iam:UpdateRole",
          "iam:UpdateUser",
          "s3:*"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

output "admin_user_access_key" {
  value     = aws_iam_access_key.admin_user.id
  sensitive = true
}

output "admin_user_secret_key" {
  value     = aws_iam_access_key.admin_user.secret
  sensitive = true
}
