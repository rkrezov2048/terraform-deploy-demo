variable "aws_region" {
  default = "us-east-1"
}

variable "profile" {
  default = "dev-new"
}

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbname" {
  type = string
}

variable "dbpass" {
  type      = string
  sensitive = true
}

