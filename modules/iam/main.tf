resource "aws_iam_role" "this" {
  for_each = { for role_name, config in var.ec2_config : role_name => config }

  name = each.value.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "instance_policies" {
  for_each = { for instance_key, instance_config in var.ec2_config : instance_key => instance_config }

  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value.policy_arn

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_role_policy_attachment" "instance_policies2" {
  for_each = { for instance_key, instance_config in var.ec2_config : instance_key => instance_config }

  role       = aws_iam_role.this[each.key].name
  policy_arn = each.value.policy_arn1

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_instance_profile" "this" {
  for_each = { for role_name, config in var.ec2_config : role_name => config }

  name = "ec2_instance_profile-${each.value.role_name}"
  role = aws_iam_role.this[each.key].name
}