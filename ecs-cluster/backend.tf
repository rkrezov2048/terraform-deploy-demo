terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.aws_region
}


terraform {
  backend "s3" {
    bucket = "dev-cognism-tfstate-test2431"
    key    = "dev/ecs-demo/terraform.tfstate"
    region = "us-east-1"
  }
}

variable "aws_region" {
  default = "us-east-1"
}

variable "profile" {
  default = "dev-new"
}