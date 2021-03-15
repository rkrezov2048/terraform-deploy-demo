data "terraform_remote_state" "vpc_dev" {
  backend = "s3"
  config = {
    bucket = "dev-cognism-tfstate-test2431"
    key    = "dev/vpc-demo/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  lb_sg = lookup(data.terraform_remote_state.vpc_dev.outputs.sg_name_and_id_list, "public_sg")
}