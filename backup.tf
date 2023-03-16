# Create full GKE backup Plan
resource "google_gke_backup_backup_plan" "full" {
    
    lifecycle {
        precondition {
        condition     = var.region !=  var.region_bck
        error_message = "Change the value of region, becouse backup regios mus be diferent that the cluster region."
        }
    }

    name     = var.name
    cluster  = var.cluster_id
    location = var.region_bck
    labels   = var.cluster_resource_labels  

    dynamic "backup_config" {
        for_each =  can(var.full["backup_config"]) ? ["true"] : []
        content {
            include_volume_data   = var.full.backup_config.include_volume_data == null ? null : var.full.backup_config.include_volume_data 
            include_secrets   = var.full.backup_config.include_secrets == null ? null : var.full.backup_config.include_secrets
            all_namespaces = var.full.backup_config.all_namespaces == null ? null :  var.full.backup_config.all_namespaces
        }
    }


   dynamic "retention_policy"  {
      for_each =   can(var.full["retention_policy"])  ? ["true"] : [] 
        content {
            backup_delete_lock_days =  lookup(var.full.retention_policy, "backup_delete_lock_days", null)
            backup_retain_days      = lookup(var.full.retention_policy, "backup_retain_days", null) 
        }
    }
    
   dynamic "backup_schedule"  {
            for_each = can(var.full["backup_schedule"])  ? var.full : []
       content {
            cron_schedule = var.full.backup_schedule.cron_schedule == null ? null : var.full.backup_schedule.cron_schedule
            paused        = var.full.backup_schedule.paused == null ? null :  var.full.backup_schedule.paused
       }
    }
  }
