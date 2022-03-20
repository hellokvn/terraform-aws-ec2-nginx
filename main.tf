module "network" {
  source          = "./network"
  access_ip       = var.access_ip
  vpc_cidr        = local.vpc_cidr
  security_groups = local.security_groups
}

module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
}