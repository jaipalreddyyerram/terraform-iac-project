module "network" {
  source = "./modules/network"
}

module "compute" {
  source    = "./modules/compute"
  subnet_id = module.network.public_subnet_id
}

module "storage" {
  source = "./modules/storage"
}

module "database" {
  source = "./modules/database"
}