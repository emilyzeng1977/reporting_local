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
//  execution_role_arn       = var.ecs_cluster_exec_role_arn
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
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
        portMappings = [
          {
            containerPort: 3000
            hostPort: 3000
          }
        ]
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