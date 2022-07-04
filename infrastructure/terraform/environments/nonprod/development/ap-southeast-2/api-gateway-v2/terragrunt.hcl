include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/api-gateway-v2"
}

dependencies {
  paths = ["../ecs-terraform"]
}

dependency "ecs-terraform" {
  config_path = "../ecs-terraform"
}

inputs = {
  nginx_port = 80
  alb_nginx_arn = dependency.ecs-terraform.outputs.alb_nginx_arn
  alb_nginx_dns_name = dependency.ecs-terraform.outputs.alb_nginx_dns_name

  security_group_id = dependency.ecs-terraform.outputs.security_group_id
  private_subnets = dependency.ecs-terraform.outputs.private_subnets
  alb_listener_arn = dependency.ecs-terraform.outputs.alb_listener_arn
}
