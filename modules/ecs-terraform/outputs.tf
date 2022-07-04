# outputs.tf

output "alb_nginx_dns_name" {
  value = aws_alb.main.dns_name
}

output "alb_nginx_arn" {
    value = aws_alb.main.arn
}

output "security_group_id" {
  value = aws_security_group.nginx_task.id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "alb_listener_arn" {
  value = aws_alb_listener.front_end.arn
}


//output "alb_nginx_port" {
//  value = nginx_port
//}

//output "alb_app_dns_name" {
//    value = aws_alb.main.dns_name
//}
//
//output "alb_app_arn" {
//    value = aws_alb.main.arn
//}
