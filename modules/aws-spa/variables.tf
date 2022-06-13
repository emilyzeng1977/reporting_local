variable "domain_name" {
  type        = string
  description = "Primary certificate domain name"
}

variable "certificate_arn" {
  type        = string
  description = "ACM Certificate ARN"
}

variable "src" {
  type        = string
  description = "Source files directory path, used to check if rebuild is needed"
  default     = "src"
}

variable "build_cmd" {
  type        = string
  description = "Build command to generate final files based on the sources"
  default     = "make build"
}

variable "dist" {
  type        = string
  description = "Path where final output will be created by the build command"
  default     = "dist"
}

variable "cloudfront_price_class" {
  description = "CloudFront distribution price class."
  default     = "PriceClass_100" // Only US,Canada,Europe
}

variable "cloudfront_min_ttl" {
  description = "The minimum TTL for the CloudFront cache"
  default     = 0
}

variable "cloudfront_default_ttl" {
  description = "The default TTL for the CloudFront cache"
  default     = 86400
}

variable "cloudfront_max_ttl" {
  description = "The maximum TTL for the CloudFront cache"
  default     = 31536000
}

output "src" {
  value = var.src
}

output "dist" {
  value = var.dist
}