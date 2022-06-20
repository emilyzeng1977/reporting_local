resource "aws_cloudwatch_log_group" "this" {
  name              = var.task_name
  retention_in_days = var.log_retention_days
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.ecs_cluster_exec_role_arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode(
    [
      {
        name   = var.task_name
        image  = var.container_image
        cpu    = var.cpu
        memory = var.memory
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = var.task_name
            awslogs-region        = var.aws_region
            awslogs-stream-prefix = var.task_name
          }
        }
      },
    ]
  )
}

resource "aws_ecs_service" "this" {
  name             = var.task_name
  cluster          = var.ecs_cluster_id
  task_definition  = aws_ecs_task_definition.this.arn
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  desired_count = 1

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.security-group.security_group_id]
    subnets          = var.subnets
  }

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [desired_count]
  }
}
