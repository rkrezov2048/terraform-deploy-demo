# -- root/main.tf ---

module "vpc_demo_1" {
  source = "github.com/rkrezov2048/terraform-module-demo/demo-module"
  cidr_block = "172.16.0.0/16"
  public_cidrs = ["172.16.10.0/24", "172.16.20.0/24"]
  private_cidrs = ["172.16.100.0/24", "172.16.101.0/24", "172.16.102.0/24"]
  
}


output "vpc_id" {
  value = module.vpc_demo_1.vpc_id
}