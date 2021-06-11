module "keypair" {
  source = "./modules/keypair"
}

module "vpc" {
  source              = "./modules/vpc"
  public_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
  regions             = ["ap-southeast-1a", "ap-southeast-1b"]
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "public_instances" {
  source   = "./modules/instance"
  key_name = module.keypair.key_name
  subnets  = module.vpc.public_subnets
  sg_id    = module.security_group.sg_public_id
}

module "private_instances" {
  source   = "./modules/instance"
  key_name = module.keypair.key_name
  subnets  = module.vpc.private_subnets
  sg_id    = module.security_group.sg_private_id
}
