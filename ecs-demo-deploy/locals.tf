locals {
  vpc_cidr = "172.16.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "ecs-public"
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