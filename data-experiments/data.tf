terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "dev-cognism-tfstate-test2431"
    key            = "dev/data/terraform.tfstate"
    region         = "us-east-1"    
  }
}

provider "aws" {
  profile = "dev-new"
  region  = "us-east-1"
}

data "terraform_remote_state" "vpc_dev" {
  backend = "s3"
  config = {
    bucket = "dev-cognism-tfstate-test2431"
    key    = "dev/vpc-demo/terraform.tfstate"
    region = "us-east-1"
  }
}


output "vpc_id" {
    value = data.terraform_remote_state.vpc_dev.outputs.vpc_id
}