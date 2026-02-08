module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "prod-vpc"
  cidr = var.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "jump_host" {
  source              = "./modules/ec2"
  name                = "jump-host"
  subnet_id           = module.vpc.public_subnets[0]
  security_groups     = [module.security_groups.jump_sg_id]
  key_name            = var.key_name
  associate_public_ip = true
}

module "private_ec2" {
  source              = "./modules/ec2"
  count               = 3
  name                = "private-ec2-${count.index}"
  subnet_id           = module.vpc.private_subnets[count.index % 2]
  security_groups     = [module.security_groups.private_sg_id]
  key_name            = var.key_name
  associate_public_ip = false
}
