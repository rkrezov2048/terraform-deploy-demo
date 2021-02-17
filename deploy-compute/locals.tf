locals {
  vpc_cidr = "172.16.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "Security group for Public Access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.public_access]
        }
        nginx = {
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = [var.public_access]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "rds Access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}

locals {
  additional_tags = {
    Environment = "Dev"
    Owner       = "DevOps-Team"
    Project     = "MailTastic"
    App         = "SMTP-ReRouting"
  }
} 