# -- root/main.tf ---

module "vpc_demo_1" {
  source          = "github.com/rkrezov2048/terraform-module-demo/demo-module"
  cidr_block      = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  public_cidrs    = [for i in range(1, 3, 1) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs   = ["172.16.100.0/24", "172.16.101.0/24", "172.16.102.0/24"]

}

