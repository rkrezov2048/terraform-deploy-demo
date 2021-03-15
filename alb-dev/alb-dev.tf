module "alb" {
  source                 = "github.com/rkrezov2048/terraform-module-demo/loadbalancer"
  public_subnets         = data.terraform_remote_state.vpc_dev.outputs.public_sub
  public_sg              = [local.lb_sg]
  tg_port                = 80
  tg_protocol            = "HTTP"
  vpc_id                 = data.terraform_remote_state.vpc_dev.outputs.vpc_id
  tg_path                = "/"
  tg_healthy_threshold   = 2
  tg_unhealthy_threshold = 2
  tg_timeout             = 2
  tg_interval            = 30
  listener_port          = 80
  tg_matcher             = "200"
  listener_protocol      = "HTTP"
}