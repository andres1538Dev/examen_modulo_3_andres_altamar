variable "cuenta" {
  type = string
}

variable "proyecto" {
  type = string
}

variable "ec2_config" {
  description = "Configuración de las instancias EC2"
  type = map(object({
    role_name     = string
    ami           = string
    instance_type = string
    subnet_id     = string
    policy_arn    = string
    policy_arn1   = string
    tagsec2       = map(string)

    root_block_device = object({
      volume_size = number
      volume_type = string
      iops        = number
    })
  }))
}

variable "sg_config" {
  description = "Configuración de los Security Group"
  type = map(object({
    name                 = string
    description          = string
    vpc_id               = string
    projectsecuritygroup = string

    tags = map(string)

    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

variable "key_name" {
  description = "Nombre de keypair"
  type        = string
}

variable "private_key_path" {
  description = "Ruta para guardar la llave privada"
  type        = string
}

variable "tags" {
  description = "Tags para aws"
  type        = map(string)
  default = {
    Name        = "andres-altamar-ec2-terraform"
    Environment = "dev"
    Owner       = "Andres Felipe Altamar Carrillo"
    Project     = "Betek"
  }
}

variable "vpc_id" {
  type    = string
  default = ""
}

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
