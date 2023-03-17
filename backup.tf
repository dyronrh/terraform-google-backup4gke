# Create full GKE backup Plan
resource "google_gke_backup_backup_plan" "full" {
    count = can(var.full) && length(var.full) > 0  ?  length(var.full) : 0
    
    lifecycle {
        precondition {
        condition     = var.region !=  var.region_bck
        error_message = "Change the value of region, becouse backup regios mus be diferent that the cluster region."
        }
    }

    name     = var.full[count.index].name
    cluster  = var.full[count.index].cluster_id
    location = var.full[count.index].region_bck
    labels   = var.full[count.index].cluster_resource_labels  

    dynamic "backup_config"  {
      for_each =   can(var.full[count.index]["backup_config"])  ? ["true"] : [] 
        content {
            include_volume_data  =  lookup(var.full[count.index].backup_config, "include_volume_data", null)
            include_secrets      =  lookup(var.full[count.index].backup_config, "include_secrets", null) 
            all_namespaces       =  lookup(var.full[count.index].backup_config, "all_namespaces", null) 
        }
    }


   dynamic "retention_policy"  {
      for_each =   can(var.full[count.index]["retention_policy"])  ? ["true"] : [] 
        content {
            backup_delete_lock_days =  lookup(var.full[count.index].retention_policy, "backup_delete_lock_days", null)
            backup_retain_days      =  lookup(var.full[count.index].retention_policy, "backup_retain_days", null) 
        }
    }

 
   dynamic "backup_schedule"  {
      for_each =   can(var.full[count.index]["backup_schedule"])  ? ["true"] : [] 
        content {
            cron_schedule =  lookup(var.full[count.index].backup_schedule, "cron_schedule", null)
            paused        =  lookup(var.full[count.index].backup_schedule, "paused", null) 
        }
    }
}
