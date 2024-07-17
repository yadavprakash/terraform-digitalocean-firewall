provider "digitalocean" {

}

locals {
  name        = "app"
  environment = "test"
  region      = "blr1"
}

module "vpc" {
  source      = "git::https://github.com/yadavprakash/terraform-digitalocean-vpc.git?ref=v1.0.0"
  name        = "test-network"
  environment = "test"
  label_order = ["name", "environment"]
  region      = "blr1"
  ip_range    = "10.10.0.0/24"

}

module "droplet" {
  source             = "git::https://github.com/yadavprakash/terraform-digitalocean-droplet.git?ref=v1.0.0"
  name               = local.name
  environment        = local.environment
  region             = local.region
  image_name         = "ubuntu-22-04-x64"
  ipv6               = false
  backups            = false
  monitoring         = false
  droplet_size       = "s-1vcpu-1gb"
  droplet_count      = 2
  block_storage_size = 5
  vpc_uuid           = module.vpc.id
  ssh_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWdZXx5WsXHQbKhRrunupZe6gayxaGLaIAtwz+xcN7Ln3DvyHJPv56IGeFjc6DPJEwavtXugD+ndVkctRlRpmg5xFek1I4+FNhqmTiVqn6DN+cNkdMEBVm8ILo8+AY8WKDuJUVxR+d2AmaBCL8EGfpMAFA1AHEpgceKq3nJbKvHlxf6obVG1uSfNR5HNvIFfq85EGSUmjY3Z6sXV4Uy201+tU6yRpu5Y0lj/jMC3i8ulXFu1245o4lNDjjUQQh4c2bGLi0L3/CDOHCFeBJaxUWC9yo18LgIv+m4YpSsRIWu014keIrJO4O+vyoybTCVSLl9kWOs8wSXjrg1zqg5VqE/w5XqI+C3Wcrf4aTDJ17oFm1UCVmtpUbHNvd3DoXInozkxk6FRAQGWz4Ni0cZrvFF6QCH5dU+xy96VNIDP9t/iwlWO86/AbLEWOrr1HSaaVujswdTHfw8kferyJuhAd20t9kNgGc2k7hsbaRNbbykP8KhJeHoDIBFILQVWXhgFc= manoj@manoj"
  user_data          = file("user-data.sh")
  inbound_rules = [
    {
      allowed_ip    = ["0.0.0.0/0"]
      allowed_ports = "22"
    },
    {
      allowed_ip    = ["0.0.0.0/0"]
      allowed_ports = "80"
    }
  ]
}

module "firewall" {
  source        = "./../../"
  name          = local.name
  environment   = local.environment
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ports = [80, 443]
  droplet_ids   = module.droplet.id
}


