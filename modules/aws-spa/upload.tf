module "upload" {
  source  = "chandan-singh/s3-object-folder/aws"
  version = "0.0.4"

  bucket                = aws_s3_bucket.this.bucket
  base_folder_path      = var.dist
  source_prefix         = var.dist

  file_glob_pattern     = "**"
  set_auto_content_type = true

  depends_on = [
    null_resource.build
  ]
}
