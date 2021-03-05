module "ecs" {
  source                         = "github.com/rkrezov2048/terraform-module-demo/ecs"
  lc_instance_type               = "t3.micro"
  lc_iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  lc_security_groups             = data.terraform_remote_state.vpc_dev.outputs.security_public
  lc_associate_public_ip_address = true
  user_data_path                 = "${path.root}/userdata.tpl"
  cluster_name                   = "ecs-dev-demo"
  asg_min_size                   = 2
  asg_max_size                   = 2
  asg_desired_capacity           = 2
  asg_vpc_zone_identifier        = data.terraform_remote_state.vpc_dev.outputs.public_sub
  asg_target_group_arns          = [data.terraform_remote_state.alb_dev.outputs.target_group_arn]
  asg_tags                       = local.asg_tags
}


module "ecs-service-dev" {
  source                    = "github.com/rkrezov2048/terraform-module-demo/ecs-service"
  ecs_task_family           = "simple-http-task"
  ecs_task_network_mode     = "bridge"
  ecs_service_name          = "simple-http"
  ecs_iam_role              = "arn:aws:iam::579229247056:role/EcsRole-RK"
  ecs_service_desired_count = 2
  ecs_service_launch_type   = "EC2"
  ecs_service_port          = 8000
  ecs_service_cluster       = module.ecs.cluster_id
  aws_lb_target_group       = data.terraform_remote_state.alb_dev.outputs.target_group_arn
  tags                      = local.additional_tags
  task_path                 = "${path.root}/task_def.tpl"
  # task_definition_name      = "web-task-nginx-dev"
  image_url     = "gkoenig/simplehttp"
  cpu           = 10
  memory        = 128
  containerPort = 8000
  logs_region   = "us-east-1"
}




resource "aws_iam_role" "ecs-instance-role" {
  name = "ecs-instance-role-demo"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_service_role" {
  role = aws_iam_role.ecs-instance-role.name
}