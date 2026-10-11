output "s3_bucket_replication_configurations_id" {
  description = "Map of id values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.id if v.id != null && length(v.id) > 0 }
}
output "s3_bucket_replication_configurations_bucket" {
  description = "Map of bucket values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.bucket if v.bucket != null && length(v.bucket) > 0 }
}
output "s3_bucket_replication_configurations_region" {
  description = "Map of region values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.region if v.region != null && length(v.region) > 0 }
}
output "s3_bucket_replication_configurations_role" {
  description = "Map of role values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.role if v.role != null && length(v.role) > 0 }
}
output "s3_bucket_replication_configurations_rule" {
  description = "Map of rule values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.rule if v.rule != null && length(v.rule) > 0 }
}
output "s3_bucket_replication_configurations_token" {
  description = "Map of token values across all s3_bucket_replication_configurations, keyed the same as var.s3_bucket_replication_configurations"
  value       = { for k, v in aws_s3_bucket_replication_configuration.s3_bucket_replication_configurations : k => v.token if v.token != null && length(v.token) > 0 }
  sensitive   = true
}

