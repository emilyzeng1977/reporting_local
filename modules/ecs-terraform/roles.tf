# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid = ""
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS task execution role
resource "aws_iam_role" "task_role" {
  name               = var.task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    aws_iam_policy.ecs_task_policy.arn
  ]
}

resource "aws_iam_policy" "ecs_task_policy" {
  name = "ecs_task_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["logs:DescribeLogGroups"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:ap-southeast-2:204532658794:log-group:/aws/ecs/simple-app-cluster:*"
      }
    ]
  })
}

//# ECS auto scale role data
//data "aws_iam_policy_document" "ecs_auto_scale_role" {
//  version = "2012-10-17"
//  statement {
//    effect = "Allow"
//    actions = ["sts:AssumeRole"]
//
//    principals {
//      type        = "Service"
//      identifiers = ["application-autoscaling.amazonaws.com"]
//    }
//  }
//}
//
//# ECS auto scale role
//resource "aws_iam_role" "ecs_auto_scale_role" {
//  name               = var.ecs_auto_scale_role_name
//  assume_role_policy = data.aws_iam_policy_document.ecs_auto_scale_role.json
//}
//
//# ECS auto scale role policy attachment
//resource "aws_iam_role_policy_attachment" "ecs_auto_scale_role" {
//  role       = aws_iam_role.ecs_auto_scale_role.name
//  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
//}
