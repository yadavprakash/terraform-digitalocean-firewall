variable "name" {
  type        = string
  default     = ""
  description = "The Firewall name."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g., 'prod')."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g., 'name', 'application'."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to indicate whether the Firewall is enabled or not."
}

variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed IP addresses."
}

variable "allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ports."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol to be used (e.g., 'tcp', 'udp')."
}

variable "droplet_ids" {
  type        = list(any)
  default     = []
  description = "List of Droplet IDs associated with the Firewall."
}

variable "load_balancer_uids" {
  type        = list(any)
  default     = []
  description = "List of Load Balancer UIDs associated with the Firewall."
}

variable "outbound_rule" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
  }))
  default = [
    {
      protocol   = "tcp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
      "::/0"]
      destination_droplet_ids = []
    },
    {
      protocol   = "udp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
      "::/0"]
    }
  ]
  description = "List of outbound rules specifying allowed protocols, port ranges, and destination addresses."
}

variable "kubernetes_ids" {
  type        = list(any)
  default     = []
  description = "List of Kubernetes IDs associated with the Firewall."
}

variable "database_cluster_id" {
  type        = string
  default     = null
  description = "ID of the associated database cluster, if applicable."
}

variable "rules" {
  type        = any
  default     = []
  description = "Additional rules or configurations for the Firewall."
}

variable "tags" {
  type        = list(any)
  default     = []
  description = "List of tags associated with the Firewall."
}
