include "root" {
  path = find_in_parent_folders()
}
terraform {
  source = "${get_path_to_repo_root()}//modules/ecs/tasks/reporting"
}

dependencies {
//  paths = ["../../cluster", "../../../lookup"]
  paths = ["../../cluster"]
}

dependency "ecs_cluster" {
  config_path = "../../cluster"
}

//dependency "lookup" {
//  config_path = "../../../lookup"
//}

inputs = {
//  container_image           = "435514637872.dkr.ecr.ap-southeast-2.amazonaws.com/mirror:alpine-git-v2.32.0"
  container_image           = "204532658794.dkr.ecr.ap-southeast-2.amazonaws.com/my-first-ecr-repo:latest"
  ecs_cluster_id            = dependency.ecs_cluster.outputs.ecs_cluster_id
  ecs_cluster_exec_role_arn = dependency.ecs_cluster.outputs.ecs_cluster_exec_role_arn
//  subnets                   = dependency.lookup.outputs.subnets_private
//  vpc_id                    = dependency.lookup.outputs.vpc.id
  vpc_id                      = ""
}
