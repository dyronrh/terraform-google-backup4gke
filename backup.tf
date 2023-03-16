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

    backup_config {
            include_volume_data   = var.full.backup_config.include_volume_data == null ? null : var.full.backup_config.include_volume_data 
            include_secrets   = var.full.backup_config.include_secrets == null ? null : var.full.backup_config.include_secrets
            all_namespaces = var.full.backup_config.all_namespaces == null ? null :  var.full.backup_config.all_namespaces
        
    }


   retention_policy  {
     
            backup_delete_lock_days = var.full.retention_policy.backup_delete_lock_days == null ? null : var.full.retention_policy.backup_delete_lock_days 
            backup_retain_days      = var.full.retention_policy.backup_retain_days == null ? null : var.full.retention_policy.backup_retain_days
      
    }
    
   dynamic "backup_schedule"  {
            for_each = var.full.backup_schedule != null ? var.full[2] : []
       content {
            cron_schedule = var.full.backup_schedule.cron_schedule == null ? null : var.full.backup_schedule.cron_schedule
            paused        = var.full.backup_schedule.paused == null ? null :  var.full.backup_schedule.paused
       }
    }
  }
