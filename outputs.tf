output "vpc_id" {
  value = module.vpc_demo_1.vpc_id
}

output "public_sub" {
  value = module.vpc_demo_1.public_sub
}

output "private_sub" {
  value = module.vpc_demo_1.private_sub
}

output "subnet_group" {
  value = module.vpc_demo_1.db_subnet_group
}

output "security_rds" {
  value = module.vpc_demo_1.db_sg
}

output "security_public" {
  value = module.vpc_demo_1.public_sg
}