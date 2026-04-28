variable "ec2_config" {
  description = "Configuración de las instancias EC2"
  type = map(object({
    role_name     = string
    ami           = string
    instance_type = string
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

variable "project" {
  description = "Proyecto"
  type        = string
}

variable "account" {
  description = "Cuenta"
  type        = string
}