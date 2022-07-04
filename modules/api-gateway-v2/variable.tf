variable "nginx_port" {
  type = number
}

variable "alb_nginx_arn" {
  type = string
}

variable "alb_nginx_dns_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "alb_listener_arn" {
  type = string
}

