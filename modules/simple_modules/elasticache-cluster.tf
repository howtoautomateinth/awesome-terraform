resource "aws_elasticache_replication_group" "elasticache-cluster" {
  availability_zones            = var.availability_zones
  replication_group_id          = "tf-${var.environment}-rep-group"
  replication_group_description = "${var.environment} replication group"
  node_type                     = var.node_type
  number_cache_clusters         = var.node_count
  parameter_group_name          = "default.redis3.2"
  port                          = 6379
}
