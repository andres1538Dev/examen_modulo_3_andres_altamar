output "bucket_ids" {
  value = module.module_s3_bucket.bucket_ids
}

output "bucket_arns" {
  value = module.module_s3_bucket.bucket_arns
}

output "website_urls" {
  description = "URL del sitio web estático"
  value       = module.module_s3_bucket.website_urls
}