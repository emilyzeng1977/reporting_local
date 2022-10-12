include "root" {
  path = find_in_parent_folders()
}

terraform {
  //  source = "git::git@github.com:emilyzeng1977/terraform_modules.git//aws-spa"
  source = "${get_path_to_repo_root()}//modules/aws-spa"
}

#dependencies {
#  paths = ["../../us-east-1/spa-acm"]
#}
#
#dependency "acm" {
#  config_path = "../../us-east-1/spa-acm"
#}

inputs = {
  //  very_important_config = "${get_repo_root()}/config/strawberries.conf"
  #  domain_name     = dependency.acm.outputs.domain_name
  #  certificate_arn = dependency.acm.outputs.certificate_arn
  domain_name     = "tom.niu26.com"
  certificate_arn = ""
  src             = "${get_repo_root()}//ui/overlay/web"
  build_cmd       = "ng build"
  dist            = "${get_repo_root()}//ui/overlay/web/dist"
}