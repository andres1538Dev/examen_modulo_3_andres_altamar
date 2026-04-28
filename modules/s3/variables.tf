variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  default     = "bucket-andres-altamar"
}

variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Región de AWS donde se desplegará"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags para el bucket de S3"
  type        = map(string)
}

variable "s3_config" {
  description = "Configuración de los buckets S3"
  type = map(object({
    bucket_name             = string
    versioning              = bool
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
    sse_algorithm           = string
    index_document          = string
    index_html_path         = string
    content_type            = string
    bucket_policy_effect    = string
    bucket_policy_principal = string
    bucket_policy_action    = string
    tags                    = map(string)
  }))
}
