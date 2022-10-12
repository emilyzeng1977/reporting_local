# ECR
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

// com.amazonaws.REGION.ecr.api
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

// com.amazonaws.REGION.ssm

// com.amazonaws.REGION.ecr.api
resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [
    aws_security_group.nginx_task.id,
    aws_security_group.app_task.id
  ]
}

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = module.vpc.private_route_table_ids
}
