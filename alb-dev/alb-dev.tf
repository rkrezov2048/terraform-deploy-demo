module "alb" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/loadbalancer"
  public_subnets         = data.terraform_remote_state.vpc_dev.outputs.public_sub
  public_sg              = data.terraform_remote_state.vpc_dev.outputs.security_public
  tg_port                = 80
  tg_protocol            = "HTTP"
  vpc_id                 = data.terraform_remote_state.vpc_dev.outputs.vpc_id
  lb_healthy_threshold   = "2"
  lb_unhealthy_threshold = "2"
  lb_timeout             = "2"
  interval               = "30"
  listener_port          = 80
  listener_protocol      = "HTTP"
}