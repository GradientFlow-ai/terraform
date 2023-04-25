# resource "aws_iam_role" "s3" {
#   name = "s3_gh_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           AWS = aws_iam_user.gh_runner.arn
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy" "s3" {
#   name = "s3_gh_policy"
#   role = aws_iam_role.s3.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "s3:*"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       }
#     ]
#   })
# }
