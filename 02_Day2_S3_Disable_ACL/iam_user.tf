resource "aws_iam_user" "Mohamed" {
  name = var.profile_name
  tags = {
    "Environment" = var.tags[0]
    "Owner" = var.tags[1]
  }
}