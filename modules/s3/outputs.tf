output "bucket_ids" {
  value = { for k, v in aws_s3_bucket.this : k => v.id }
}

output "bucket_arns" {
  value = { for k, v in aws_s3_bucket.this : k => v.arn }
}

output "website_urls" {
  value = { for k, v in aws_s3_bucket_website_configuration.this : k => v.website_endpoint }
}
