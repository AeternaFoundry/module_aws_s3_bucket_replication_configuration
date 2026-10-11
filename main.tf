resource "aws_s3_bucket_replication_configuration" "s3_bucket_replication_configurations" {
  for_each = var.s3_bucket_replication_configurations

  bucket = each.value.bucket
  role   = each.value.role
  region = each.value.region
  token  = each.value.token

  dynamic "rule" {
    for_each = each.value.rule
    content {
      dynamic "delete_marker_replication" {
        for_each = rule.value.delete_marker_replication != null ? [rule.value.delete_marker_replication] : []
        content {
          status = delete_marker_replication.value.status
        }
      }
      destination {
        dynamic "access_control_translation" {
          for_each = rule.value.destination.access_control_translation != null ? [rule.value.destination.access_control_translation] : []
          content {
            owner = access_control_translation.value.owner
          }
        }
        account = rule.value.destination.account
        bucket  = rule.value.destination.bucket
        dynamic "encryption_configuration" {
          for_each = rule.value.destination.encryption_configuration != null ? [rule.value.destination.encryption_configuration] : []
          content {
            replica_kms_key_id = encryption_configuration.value.replica_kms_key_id
          }
        }
        dynamic "metrics" {
          for_each = rule.value.destination.metrics != null ? [rule.value.destination.metrics] : []
          content {
            dynamic "event_threshold" {
              for_each = metrics.value.event_threshold != null ? [metrics.value.event_threshold] : []
              content {
                minutes = event_threshold.value.minutes
              }
            }
            status = metrics.value.status
          }
        }
        dynamic "replication_time" {
          for_each = rule.value.destination.replication_time != null ? [rule.value.destination.replication_time] : []
          content {
            status = replication_time.value.status
            time {
              minutes = replication_time.value.time.minutes
            }
          }
        }
        storage_class = rule.value.destination.storage_class
      }
      dynamic "existing_object_replication" {
        for_each = rule.value.existing_object_replication != null ? [rule.value.existing_object_replication] : []
        content {
          status = existing_object_replication.value.status
        }
      }
      dynamic "filter" {
        for_each = rule.value.filter != null ? [rule.value.filter] : []
        content {
          dynamic "and" {
            for_each = filter.value.and != null ? [filter.value.and] : []
            content {
              prefix = and.value.prefix
              tags   = and.value.tags
            }
          }
          prefix = filter.value.prefix
          dynamic "tag" {
            for_each = filter.value.tag != null ? [filter.value.tag] : []
            content {
              key   = tag.value.key
              value = tag.value.value
            }
          }
        }
      }
      id       = rule.value.id
      prefix   = rule.value.prefix
      priority = rule.value.priority
      dynamic "source_selection_criteria" {
        for_each = rule.value.source_selection_criteria != null ? [rule.value.source_selection_criteria] : []
        content {
          dynamic "replica_modifications" {
            for_each = source_selection_criteria.value.replica_modifications != null ? [source_selection_criteria.value.replica_modifications] : []
            content {
              status = replica_modifications.value.status
            }
          }
          dynamic "sse_kms_encrypted_objects" {
            for_each = source_selection_criteria.value.sse_kms_encrypted_objects != null ? [source_selection_criteria.value.sse_kms_encrypted_objects] : []
            content {
              status = sse_kms_encrypted_objects.value.status
            }
          }
        }
      }
      status = rule.value.status
    }
  }
}

