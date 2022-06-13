include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://lab.identitii.com/platform/terraform-modules.git//aws-spa"
}

#dependencies {
#  paths = ["../../us-east-1/spa-acm"]
#}
#
#dependency "acm" {
#  config_path = "../../us-east-1/spa-acm"
#}

inputs = {
#  domain_name     = dependency.acm.outputs.domain_name
#  certificate_arn = dependency.acm.outputs.certificate_arn
  domain_name     = "zeng.emily02.com"
  certificate_arn = ""

  src             = "${get_repo_root()}//ui/overlay/web"
  build_cmd       = "ng build"
  dist            = "${get_repo_root()}//ui/overlay/web/dist"
}
