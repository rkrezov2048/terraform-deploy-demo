module "database_rds" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/database"
  db_storage             = 10
  db_instance_class      = "db.t2.micro"
  db_engine_version      = "5.7.22"
  db_name                = var.dbname
  db_username            = var.dbuser
  db_password            = var.dbpass
  vpc_security_group_ids = data.terraform_remote_state.vpc_dev.outputs.security_rds
  db_identifier          = "mtc-db"
  db_subnet_group_name   = data.terraform_remote_state.vpc_dev.outputs.subnet_group[0]
  skip_final_snapshot    = true

}