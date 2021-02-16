# -- root/main.tf ---

module "vpc_demo_1" {
  source          = "github.com/rkrezov2048/terraform-module-demo/demo-module"
  cidr_block      = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_cidrs    = [for i in range(1, 3, 1) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs   = ["172.16.100.0/24", "172.16.101.0/24", "172.16.102.0/24"]
  db_subnet_group = true
  additional_tags = local.additional_tags

}

module "database_rds" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/database"
  db_storage             = 10
  db_instance_class      = "db.t2.micro"
  db_engine_version      = "5.7.22"
  db_name                = var.dbname
  db_username            = var.dbuser
  db_password            = var.dbpass
  vpc_security_group_ids = module.vpc_demo_1.db_sg
  db_identifier          = "mtc-db"
  db_subnet_group_name   = module.vpc_demo_1.db_subnet_group[0]
  skip_final_snapshot    = true

}


module "loadbalancer" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/loadbalancer"
  public_subnets         = module.vpc_demo_1.public_sub
  public_sg              = module.vpc_demo_1.db_sg
  tg_port                = 8080
  tg_protocol            = "HTTP"
  vpc_id                 = module.vpc_demo_1.vpc_id
  lb_healthy_threshold   = "2"
  lb_unhealthy_threshold = "2"
  lb_timeout             = "2"
  interval               = "30"
  listener_port          = 8000
  listener_protocol      = "HTTP"
}

module "ec2" {
  source           = "github.com/rkrezov2048/terraform-module-demo/compute"
  instance_count   = 2
  instance_type    = "t3.micro"
  public_sg        = module.vpc_demo_1.public_sg
  public_sub       = module.vpc_demo_1.public_sub
  vol_size         = 10
  additional_tags  = local.additional_tags
  key_name         = "terra_demo"
  public_key_path  = "/Users/rkzv/.ssh/terra_demo.pub"
  used_data_path   = "${path.root}/userdata.tpl"
  dbname           = var.dbname
  dbuser           = var.dbuser
  dbpass           = var.dbpass
  db_endpoint      = module.database_rds.endpoint
  target_group_arn = module.loadbalancer.target_group_arn
}