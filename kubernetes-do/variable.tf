variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "dev-cluster"
}

variable "region" {
  description = "The region where the cluster will be created"
  type        = string
  default     = "nyc1"
}

variable "k8s_version" {
  description = "The version of Kubernetes to use for the cluster"
  type        = string
  default     = "1.30.2-do.0"
}

variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
  default     = "worker-pool"
}

variable "node_size" {
  description = "The size of the nodes in the node pool"
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "auto_scale" {
  description = "Whether to enable auto-scaling for the node pool"
  type        = bool
  default     = true
}

variable "min_nodes" {
  description = "The minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "The maximum number of nodes in the node pool"
  type        = number
  default     = 10
}

variable "taint_key" {
  description = "The key for the taint"
  type        = string
  default     = "workloadKind"
}

variable "taint_value" {
  description = "The value for the taint"
  type        = string
  default     = "database"
}

variable "taint_effect" {
  description = "The effect of the taint"
  type        = string
  default     = "NoSchedule"
}
