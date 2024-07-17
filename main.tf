
module "labels" {
  source      = "git::https://github.com/yadavprakash/terraform-digitalocean-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
}

#tfsec:ignore:digitalocean-compute-no-public-egress
resource "digitalocean_firewall" "default" {
  count       = var.enabled == true && var.database_cluster_id == null ? 1 : 0
  name        = format("%s-firewall", module.labels.id)
  droplet_ids = var.droplet_ids
  dynamic "inbound_rule" {
    iterator = port
    for_each = var.allowed_ports
    content {
      port_range                = port.value
      protocol                  = var.protocol
      source_addresses          = var.allowed_ip
      source_droplet_ids        = var.droplet_ids
      source_load_balancer_uids = var.load_balancer_uids
      source_kubernetes_ids     = var.kubernetes_ids
      source_tags               = var.tags
    }
  }
  dynamic "outbound_rule" {
    for_each = var.outbound_rule
    content {
      protocol                       = outbound_rule.value.protocol
      port_range                     = outbound_rule.value.port_range
      destination_addresses          = outbound_rule.value.destination_addresses
      destination_droplet_ids        = var.droplet_ids
      destination_kubernetes_ids     = var.kubernetes_ids
      destination_load_balancer_uids = var.load_balancer_uids
      destination_tags               = var.tags
    }
  }

  tags = [
    module.labels.name,
    module.labels.environment,
    module.labels.managedby
  ]
}


resource "digitalocean_database_firewall" "default" {
  count      = var.enabled == true && var.database_cluster_id != null ? 1 : 0
  cluster_id = var.database_cluster_id
  dynamic "rule" {
    for_each = var.rules
    content {
      type  = rule.value.type
      value = rule.value.value
    }
  }
}