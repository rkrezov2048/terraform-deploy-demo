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