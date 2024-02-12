provider "digitalocean" {

}

locals {
  name        = "app"
  environment = "test"
}

module "database_firewall" {
  source              = "./../../"
  name                = local.name
  environment         = local.environment
  database_cluster_id = "db-mysql-nyc1-64954-do-user-14624882-0.b.db.ondigitalocean.com"
  rules = [
    {
      type  = "ip_addr"
      value = "192.168.1.1"
    },
  ]
}
