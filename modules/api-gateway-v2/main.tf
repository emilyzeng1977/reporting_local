resource "random_pet" "this" {
  length = 2
}

# VPC Link
resource "aws_apigatewayv2_vpc_link" "this" {
  name = "vpc-link-nginx"
  //  target_arns = [aws_alb.main.arn]
  security_group_ids = [var.security_group_id]
  subnet_ids = var.private_subnets
}

###################
# HTTP API Gateway
###################

module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "${random_pet.this.id}-http-vpc-links"
  description   = "HTTP API Gateway with VPC links"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  create_api_domain_name = false

  integrations = {
    "GET /alb-internal-route" = {
      connection_type    = "VPC_LINK"
      vpc_link           = "my-vpc"
      integration_uri    = var.alb_listener_arn
      integration_type   = "HTTP_PROXY"
      integration_method = "ANY"
      connection_id      = "${aws_apigatewayv2_vpc_link.this.id}"
    }
  }

  tags = {
    Name = "private-api"
  }
}
