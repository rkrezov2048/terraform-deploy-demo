variable "aws_region" {
  default = "us-east-1"
}

variable "access_ip" {
  type = string
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