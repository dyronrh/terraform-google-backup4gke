# Create full GKE backup Plan
resource "google_gke_backup_backup_plan" "full" {
    
    lifecycle {
        precondition {
        condition     = google_container_cluster.primary.region ==  var.region
        error_message = "Change the value of region, becouse backup regios mus be diferent that the cluster region."
        }
    }

    name     = lookup(var.full, "name", null)
    cluster  = google_container_cluster.primary.id
    location = lookup(var.full, "region", null) 
    labels   = ookup(var.full, "cluster_resource_labels", null)   

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

  # Create GKE backup only for namespaces (workloads)
  resource "google_gke_backup_backup_plan" "namespaces_bck" {
    
    lifecycle {
        precondition {
        condition     = google_container_cluster.primary.region ==  var.region
        error_message = "Change the value of region, becouse backup regios mus be diferent that the cluster region."
        }
    }

    name     = lookup(var.namespaces_bck, "name", null)
    cluster  = google_container_cluster.primary.id
    location = lookup(var.namespaces_bck, "region", null) 
    labels   = ookup(var.namespaces_bck, "cluster_resource_labels", null)   

    dynamic "backup_config" {
      for_each = lookup(var.namespaces_bck, "backup_config", [])
        content {
            include_volume_data   = lookup(var.namespaces_bck.backup_config, "include_volume_data", null)
            include_secrets   = lookup(var.namespaces_bck.backup_config, "include_secrets", null)
            all_namespaces = lookup(var.namespaces_bck.backup_config, "all_namespaces", null)
        }
    }


    dynamic "retention_policy" {
      for_each = lookup(var.namespaces_bck, "retention_policy", [])
        content {
            backup_delete_lock_days = lookup(var.namespaces_bck.retention_policy, "backup_delete_lock_days", null)
            backup_retain_days      = lookup(var.namespaces_bck.retention_policy, "backup_retain_days", null)
      }
    }
    
    dynamic "backup_schedule" {
      for_each = lookup(var.namespaces_bck, "backup_schedule", [])
        content {
            cron_schedule = lookup(var.namespaces_bck.backup_schedule, "cron_schedule", null)
            paused        = lookup(var.namespaces_bck.backup_schedule, "paused", null)
      }
    }
  }