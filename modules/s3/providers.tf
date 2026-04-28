terraform {
 required_version = ">= 1.5" #versión de terraform que se usará
 required_providers {
 aws = {
  # Uso el proveedor oficial de AWS de HashiCorp
 source = "hashicorp/aws"
 version = "~> 5.0"
 }
 }
}
provider "aws" {
 region = var.region # esta me sirve para pasar como variable la región donde se debe desplegar
}