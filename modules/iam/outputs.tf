output "instance_profile_names" {
  value = { for role_name, profile in aws_iam_instance_profile.this : role_name => profile.name }
}