module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "3.5.0"

  name               = var.cluster_name
  container_insights = true

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    {
      base              = "1"
      capacity_provider = "FARGATE"
      weight            = "1"
    },
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = "5"
    }
  ]

  tags = var.tags
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS Cluster"
  value       = module.ecs.ecs_cluster_arn
}
output "ecs_cluster_id" {
  description = "ID of the ECS Cluster"
  value       = module.ecs.ecs_cluster_id
}
output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.ecs_cluster_name
}
