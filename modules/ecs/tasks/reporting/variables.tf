variable "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  type        = string
}

variable "ecs_cluster_exec_role_arn" {
  type        = string
  description = "ARN of the IAM role used to run ECS tasks"
}

variable "log_retention_days" {
  description = "Number of days to retain logs (default: 1)"
  type        = number
  default     = 1
}

variable "task_name" {
  description = "Name of the task (default: 'reporting')"
  type        = string
  default     = "reporting"
}

variable "container_image" {
  type        = string
  description = "Container image to use for the task (default: 'hello-world')"
  default     = "hello-world"
}

variable "cpu" {
  type        = number
  description = "Amount of CPU to allocate to task (default: 256)"
  default     = 256
}

variable "memory" {
  type        = number
  description = "Amount of RAM to allocate to task (default: 512)"
  default     = 512
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID number"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security groups to use with task"
  default     = []
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets to use with task"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

output "aws_alb" {
  value = aws_alb.application_load_balancer.dns_name
}
