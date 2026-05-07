module "network" {
  source = "./modules/network"

  common_tags = local.common_tags
}

module "compute" {
  source = "./modules/compute"

  subnet_ids = module.network.public_subnet_ids

  security_group_id = module.network.security_group_id

  common_tags = local.common_tags
}

module "storage" {
  source = "./modules/storage"

  common_tags = local.common_tags
}

module "database" {
  source = "./modules/database"

  private_subnet_ids = module.network.private_subnet_ids

  common_tags = local.common_tags
}