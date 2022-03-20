module "network" {
  source          = "./network"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}

module "ec2" {
  source        = "./ec2"
  public_sg     = module.network.public_sg
  public_subnet = module.network.public_subnet
}