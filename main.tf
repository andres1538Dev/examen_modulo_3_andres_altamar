# Creo las security group
module "module_security_group" {
  source    = "./modules/security_group"
  sg_config = var.sg_config
  tags      = var.tags
  project   = var.proyecto
  account   = var.cuenta
  vpc_id    = var.vpc_id
}

# Genero las instancias.
module "module_ec2_instances" {
  source                = "./modules/ec2"
  security_group_ids    = module.module_security_group.security_group_ids
  iam_instance_profiles = module.module_iam_config.instance_profile_names
  ec2_config            = var.ec2_config
  key_name              = var.key_name
  private_key_path      = var.private_key_path
  tags                  = var.tags
}

# Creo los roles y permisos IAM para que las instancias EC2
module "module_iam_config" {
  source     = "./modules/iam"
  ec2_config = var.ec2_config
  project    = var.proyecto
  account    = var.cuenta
}

# Creo el bucket S3 donde alojare mi pagina web statica.
module "module_s3_bucket" {
  source    = "./modules/s3"
  s3_config = var.s3_config
  tags      = var.tags
}