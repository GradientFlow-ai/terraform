resource "aws_iam_user" "superadmin" {
  name = "superadmin"
}

resource "aws_iam_policy" "admin_policy" {
  name        = "superadmin"
  description = "Administrator policy"
  policy      = data.aws_iam_policy_document.admin_policy.json
}

data "aws_iam_policy_document" "admin_policy" {
  statement {
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "superadmin_policy_attachment" {
  policy_arn = aws_iam_policy.admin_policy.arn
  user       = aws_iam_user.superadmin.name
}
