variable "project_id" {
    type        = string
    description = "define the project on gcp"
    default     = ""
}

variable "cluster_id" {
    type        = string
    description = "define the cluster_id of  gcp  project"
    default     = null
}

variable "name" {
    type        = string
    description = "define the name of  gcp backup object"
    default     = null
}

variable "region" {
    type        = string
    description = "define project region"
    default     = null
}

variable "region_bck" {
    type        = string
    description = "define backup project region"
    default     = null
}


variable "zone" {
    type        = string
    description = "define project zone"
    default     = ""
}

variable "vpc_network" {
    type        = string
    description = "select the vpc"
    default     = ""
}

variable "sub_network" {
    type        = string
    description = "define sub network"
    default     = ""
}



variable "cluster_resource_labels" {
  type = map
  default = {
   # "cmdb" = "backup-",
  }
}
