variable "vpc_name" {
  description = "Name of VPC, as set in 'Name' tag"
  type        = string
  default     = "terragruntVPC"
}

data "aws_vpc" "this" {
  tags = {
    Name = var.vpc_name
  }
}

output "vpc" {
  value = data.aws_vpc.this
}
