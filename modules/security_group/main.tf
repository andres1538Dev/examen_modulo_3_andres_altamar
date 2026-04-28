resource "aws_security_group" "this" {
  for_each = { for name, config in var.sg_config : name => config }

  name   = "ause1-sg-${var.account}-${each.value.projectsecuritygroup}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = lookup(each.value, "ingress_rules", [])

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "ause1-sg-${var.account}-${var.project}-ec2"
    }
  )
}