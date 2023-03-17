output "region" {
  value       = var.full.*.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.full.*.project_id
  description = "GCloud Project ID"
}

