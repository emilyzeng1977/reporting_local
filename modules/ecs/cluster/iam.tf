resource "aws_iam_role" "this" {
  name                = "ecs-task-exec"
  assume_role_policy  = data.aws_iam_policy_document.this.json
  managed_policy_arns = [aws_iam_policy.this.arn]
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "this" {
  name = "ecs-task-exec-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

output "ecs_cluster_exec_role_arn" {
  value = aws_iam_role.this.arn
}
