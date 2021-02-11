# -- root/main.tf ---

module "vpc_demo_1" {
  source          = "github.com/rkrezov2048/terraform-module-demo/demo-module"
  cidr_block      = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_cidrs    = [for i in range(1, 3, 1) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs   = ["172.16.100.0/24", "172.16.101.0/24", "172.16.102.0/24"]
  db_subnet_group = true

}

module "database_rds" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/database"
  db_storage             = 10
  db_instance_class      = "db.t2.micro"
  db_engine_version      = "5.7.22"
  db_name                = "rancher"
  db_username            = "john"
  db_password            = "tempus435"
  vpc_security_group_ids = module.vpc_demo_1.db_sg
  db_identifier          = "mtc-db"
  db_subnet_group_name   = module.vpc_demo_1.db_subnet_group[0]
  skip_final_snapshot    = true

}