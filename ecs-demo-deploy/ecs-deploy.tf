module "ecs_vpc_demo" {
  source          = "github.com/rkrezov2048/terraform-module-demo/demo-module"
  cidr_block      = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_cidrs    = [for i in range(1, 3, 1) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs   = ["172.16.100.0/24", "172.16.101.0/24", "172.16.102.0/24"]
  db_subnet_group = false
  additional_tags = local.additional_tags
}

module "ecs" {
  source                         = "github.com/rkrezov2048/terraform-module-demo/ecs"
  lc_instance_type               = "t3.micro"
  lc_iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  lc_security_groups             = module.ecs_vpc_demo.public_sg
  lc_associate_public_ip_address = true
  user_data_path                 = "${path.root}/userdata.tpl"
  cluster_name                   = "ecs-dev-demo"
  asg_min_size                   = 2
  asg_max_size                   = 2
  asg_desired_capacity           = 2
  asg_vpc_zone_identifier        = module.ecs_vpc_demo.public_sub
}