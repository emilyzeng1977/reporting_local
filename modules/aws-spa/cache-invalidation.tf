#resource "null_resource" "cache-invalidation" {
#
#  provisioner "local-exec" {
#    interpreter = ["bash", "-ex"]
#    command     = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.this.id} --paths '/index.html'"
#  }
#
#  depends_on = [
#    module.upload
#  ]
#}
