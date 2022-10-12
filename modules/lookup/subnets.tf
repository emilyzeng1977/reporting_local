data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*-private-*"]
  }
}

output "subnets_private" {
  value = data.aws_subnets.private.ids
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*-public-*"]
  }
}

output "subnets_public" {
  value = data.aws_subnets.public.ids
}

data "aws_subnets" "db" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*-db-*"]
  }
}

output "subnets_db" {
  value = data.aws_subnets.db.ids
}
