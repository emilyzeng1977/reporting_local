resource "aws_ecs_task_definition" "app" {
  family                   = "app-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = jsonencode(
    [
      {
        image: "204532658794.dkr.ecr.ap-southeast-2.amazonaws.com/app:latest",
        cpu: 1024,
        memory: 2048,
        name: "app-app",
        networkMode: "awsvpc",
        portMappings: [
          {
            containerPort: 3000,
            hostPort: 3000
          }
        ]
      }
    ]
  )
}

resource "aws_security_group" "app_task" {
  name        = "example-task-security-group_2"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = "3000"
    cidr_blocks = [ aws_vpc.default.cidr_block ]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.app_task.id]
    subnets         = aws_subnet.private.*.id
    assign_public_ip = false
  }

  service_registries {
    registry_arn = aws_service_discovery_service.simple-stack-app.arn
    container_name = "app"
  }

  depends_on = [ aws_ecs_cluster.main, aws_lb_listener.hello_world, aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy, aws_security_group.app_task ]
}