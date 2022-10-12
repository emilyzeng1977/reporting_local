variable "cluster_name" {
  type        = string
  description = "Name of ECS cluster"
  default     = "TerraformCluster"
}

variable "tags" {
  description = "Tags to apply to things"
  type        = map(string)
  default = {
    "Managed By" = "Terraform"
  }
}
