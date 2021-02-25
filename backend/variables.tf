variable "name_prefix" {
  default = "cognism"
}

variable "full_access_users" {
  type    = list(any)
  default = []
}

variable "read_only_users" {
  type    = list(any)
  default = []
}

variable "profile" {
  type    = string
  default = "dev-new"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
} 