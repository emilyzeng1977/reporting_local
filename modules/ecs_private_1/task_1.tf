resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = <<DEFINITION
[
  {
    "image": "204532658794.dkr.ecr.ap-southeast-2.amazonaws.com/nginx:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "nginx-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_security_group" "nginx_task" {
  name        = "example-task-security-group_1"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol        = "tcp"
//    from_port       = 3000
//    to_port         = 3000
    from_port   = 0
    to_port     = 0
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.nginx_task.id]
    subnets         = aws_subnet.private.*.id
  }

//  service_registries {
//    registry_arn = aws_service_discovery_service.simple-stack-nginx.arn
//    container_name = "nginx"
//  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.id
    container_name   = "nginx-app"
//    container_port   = 3000
    container_port = 80
  }

  depends_on = [aws_lb_listener.nginx]
}
