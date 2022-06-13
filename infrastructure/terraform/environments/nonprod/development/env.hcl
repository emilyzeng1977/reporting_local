# We need to copy the content of env/dev.env to here

locals {
  SERVICE = "reporting"
  SLS_STAGE = "dev-tf"
  VPC_SECURITY_GROUP_ID = "sg-0fbbcf27759b3245d"
  VPC_SUBNET_ID = "subnet-0290223dfae8a79b8"
  AURORA_CONNECTION_STRING = "postgres://postgres:postgres@localhost:5432/customer?sslmode=enable"
  REDIS_ENDPOINT = "redis-001.redis.7dqnvt.apse2.cache.amazonaws.com:6379"
}

