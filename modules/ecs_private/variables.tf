variable "task_name" {
  description = "Name of the task (default: 'reporting')"
  type        = string
  default     = "reporting"
}

variable "container_image" {
  type        = string
  description = "Container image to use for the task (default: 'hello-world')"
  default     = "204532658794.dkr.ecr.ap-southeast-2.amazonaws.com/my-first-ecr-repo:latest"
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

variable "app_count" {
  type = number
  default = 1
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-southeast-2"
}
