# Create full GKE backup Plan
resource "google_gke_backup_backup_plan" "full" {
    
    lifecycle {
        precondition {
        condition     = vaar.region ==  var.region_bck
        error_message = "Change the value of region, becouse backup regios mus be diferent that the cluster region."
        }
    }

    name     = var.name
    cluster  = var.cluster_id
    location = var.region_bck
    labels   = var.cluster_resource_labels  

    dynamic "backup_config" {
      for_each = lookup(var.full, "backup_config", [])
        content {
            include_volume_data   = lookup(var.full.backup_config, "include_volume_data", null)
            include_secrets   = lookup(var.full.backup_config, "include_secrets", null)
            all_namespaces = lookup(var.full.backup_config, "all_namespaces", null)
        }
    }


    dynamic "retention_policy" {
      for_each = lookup(var.full, "retention_policy", [])
        content {
            backup_delete_lock_days = lookup(var.full.retention_policy, "backup_delete_lock_days", null)
            backup_retain_days      = lookup(var.full.retention_policy, "backup_retain_days", null)
      }
    }
    
    dynamic "backup_schedule" {
      for_each = lookup(var.full, "backup_schedule", [])
        content {
            cron_schedule = lookup(var.full.backup_schedule, "cron_schedule", null)
            paused        = lookup(var.full.backup_schedule, "paused", null)
      }
    }
  }
