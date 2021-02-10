terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "demo"
  region  = "us-east-1"
}

module "vpc_demo_1" {
  source = "github.com/rkrezov2048/terraform-module-demo/demo-module"
}


output "vpc_id" {
  value = module.vpc_demo_1.vpc_id
}