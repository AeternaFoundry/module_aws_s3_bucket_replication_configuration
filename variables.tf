variable "s3_bucket_replication_configurations" {
  description = <<EOT
Map of s3_bucket_replication_configurations, attributes below
Required:
    - bucket
    - role
    - rule (block):
        - delete_marker_replication (optional, block):
            - status (required)
        - destination (required, block):
            - access_control_translation (optional, block):
                - owner (required)
            - account (optional)
            - bucket (required)
            - encryption_configuration (optional, block):
                - replica_kms_key_id (required)
            - metrics (optional, block):
                - event_threshold (optional, block):
                    - minutes (required)
                - status (required)
            - replication_time (optional, block):
                - status (required)
                - time (required, block):
                    - minutes (required)
            - storage_class (optional)
        - existing_object_replication (optional, block):
            - status (required)
        - filter (optional, block):
            - and (optional, block):
                - prefix (optional)
                - tags (optional)
            - prefix (optional)
            - tag (optional, block):
                - key (required)
                - value (required)
        - id (optional)
        - prefix (optional)
        - priority (optional)
        - source_selection_criteria (optional, block):
            - replica_modifications (optional, block):
                - status (required)
            - sse_kms_encrypted_objects (optional, block):
                - status (required)
        - status (required)
Optional:
    - region
    - token
EOT

  type = map(object({
    bucket = string
    role   = string
    region = optional(string)
    token  = optional(string)
    rule = list(object({
      delete_marker_replication = optional(object({
        status = string
      }))
      destination = object({
        access_control_translation = optional(object({
          owner = string
        }))
        account = optional(string)
        bucket  = string
        encryption_configuration = optional(object({
          replica_kms_key_id = string
        }))
        metrics = optional(object({
          event_threshold = optional(object({
            minutes = number
          }))
          status = string
        }))
        replication_time = optional(object({
          status = string
          time = object({
            minutes = number
          })
        }))
        storage_class = optional(string)
      })
      existing_object_replication = optional(object({
        status = string
      }))
      filter = optional(object({
        and = optional(object({
          prefix = optional(string)
          tags   = optional(map(string))
        }))
        prefix = optional(string)
        tag = optional(object({
          key   = string
          value = string
        }))
      }))
      id       = optional(string)
      prefix   = optional(string)
      priority = optional(number)
      source_selection_criteria = optional(object({
        replica_modifications = optional(object({
          status = string
        }))
        sse_kms_encrypted_objects = optional(object({
          status = string
        }))
      }))
      status = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.s3_bucket_replication_configurations : (
        length(v.rule) >= 1 && length(v.rule) <= 1000
      )
    ])
    error_message = "Each rule list must contain between 1 and 1000 items"
  }
  # Note: 20 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

