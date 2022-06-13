resource "null_resource" "build" {
  # Trigger build if the sha of any file in the src changes
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(var.src, "**") : filesha1(format("%s/%s", var.src, f))]))
  }
  provisioner "local-exec" {
    working_dir = var.src
    command     = var.build_cmd
  }

#  depends_on = [
#    aws_s3_bucket.this
#  ]
}
