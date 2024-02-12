output "id" {
  value = join("", digitalocean_firewall.default[*].id)
}
output "status" {
  value = join("", digitalocean_firewall.default[*].status)
}
output "created_at" {
  value = join("", digitalocean_firewall.default[*].created_at)
}
output "name" {
  value = join("", digitalocean_firewall.default[*].name)
}
output "droplet_ids" {
  value = digitalocean_firewall.default[*].droplet_ids
}
output "tags" {
  value = digitalocean_firewall.default[*].tags
}
output "inbound_rule" {
  value = digitalocean_firewall.default[*].inbound_rule
}
output "outbound_rule" {
  value = digitalocean_firewall.default[*].outbound_rule
}
