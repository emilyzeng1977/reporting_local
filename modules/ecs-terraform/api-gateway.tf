# VPC Link
resource "aws_api_gateway_vpc_link" "this" {
  name = "vpc-link-nginx"
  target_arns = [aws_alb.main.arn]
}

# API Gateway, Private Integration with VPC Link
# and deployment of a single resource that will take ANY
# HTTP method and proxy the request to the NLB
resource "aws_api_gateway_rest_api" "main" {
  name = "api-gateway-nginx"
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "test"

}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_resource.main.id}"
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_resource.main.id}"
  http_method = "${aws_api_gateway_method.main.http_method}"
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  type                    = "HTTP_PROXY"
  uri                     = "http://${aws_alb.main.dns_name}:${var.nginx_port}/{proxy}"
  integration_http_method = "GET"
  connection_type = "VPC_LINK"
  connection_id   = "${aws_api_gateway_vpc_link.this.id}"

  depends_on = [aws_alb.main, aws_api_gateway_vpc_link.this]
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name = "dev"
  depends_on = [aws_api_gateway_integration.main]
  variables = {
    # just to trigger redeploy on resource changes
    resources = join(", ", [aws_api_gateway_resource.main.id])
    # note: redeployment might be required with other gateway changes.
    # when necessary run `terraform taint <this resource's address>`
  }
  lifecycle {
    create_before_destroy = true
  }
}
