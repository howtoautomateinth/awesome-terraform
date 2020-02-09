module "dev-elasticache" {
  source = "../../simple_modules"
  environment        = "dev"
  node_count         = 1
  node_type          = "cache.m3.medium"
  availability_zones = ["us-east-1a", "us-east-1b"]
}