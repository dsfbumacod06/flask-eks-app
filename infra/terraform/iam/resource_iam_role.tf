
resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": var.aws_service
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "aws-managed-policies" {
  for_each = toset(var.aws_managed_roles)
  policy_arn = each.key
  role = aws_iam_role.iam_role.name
}

