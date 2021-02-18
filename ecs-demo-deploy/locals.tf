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
    alb_ecs = {
      name        = "alb_ecs_sg"
      description = "Security group for the Loadbalancer"
      ingress = {
        mysql = {
          from        = 0
          to          = 0
          protocol    = "-1"
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


locals {
  asg_tags = [
    {
      key               = "Name"
      value             = "Ecs-Cluster-Demo"
      propage_at_launch = true
    },
    {
      key               = "Environment"
      value             = "Dev"
      propage_at_launch = true
    },
    {
      key               = "Project"
      value             = "MailTastic"
      propage_at_launch = true
    },
    {
      key               = "App"
      value             = "SMTP-Routing"
      propage_at_launch = true
    },
    {
      key               = "Owner"
      value             = "MailTastic-Dev-Team"
      propage_at_launch = true
    },
  ]
}