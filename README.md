# Terraform Infrastructure as Code (IaC) - digitalocean firewall Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This Terraform module creates structured firewall for digitalocean resources with specific attributes.

## Usage

- Use the module by referencing its source and providing the required variables.
Example:Basic
```hcl
module "firewall" {
  source        = "git::https://github.com/yadavprakash/terraform-digitalocean-firewall.git?ref=v1.0.0"
  name          = local.name
  environment   = local.environment
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ports = [22, 80]

}
```
Example:Complete

```hcl
module "firewall" {
  source        = "git::https://github.com/yadavprakash/terraform-digitalocean-firewall.git?ref=v1.0.0"
  name          = local.name
  environment   = local.environment
  allowed_ip    = ["0.0.0.0/0"]
  allowed_ports = [80, 443]
  droplet_ids   = module.droplet[*].id
}
```

Example:firewall-firewalls
```hcl
module "firewall_firewall" {
  source              = "git::https://github.com/yadavprakash/terraform-digitalocean-firewall.git?ref=v1.0.0"
  name                = local.name
  environment         = local.environment
  firewall_cluster_id = "db-mysql-nyc1-64954-do-user-14624882-0.b.db.ondigitalocean.com"
  rules = [
    {
      type  = "ip_addr"
      value = "192.168.1.1"
    },
  ]
}

```
Please ensure you specify the correct 'source' path for the module.

## Module Inputs

- `name`: The Firewall name.
- `environment`: Environment (e.g. `prod).
- `label_order`: Label order, e.g. `name`,`application`.
- `enabled`: Flag to control the firewall creation.


## Module Outputs
- This module currently does not provide any outputs.

# Examples:Basic
For detailed examples on how to use this module, please refer to the '[example](https://github.com/yadavprakash/terraform-digitalocean-firewall/tree/master/_example/basic)' directory within this repository.
# Examples:complete
For detailed examples on how to use this module, please refer to the '[example](https://github.com/yadavprakash/terraform-digitalocean-firewall/tree/master/_example/complete)' directory within this repository.
# Examples:mongodb
For detailed examples on how to use this module, please refer to the '[example](https://github.com/yadavprakash/terraform-digitalocean-firewall/tree/master/_example/firewall-databases)' directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/yadavprakash/terraform-digitalocean-firewall/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.28.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.28.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/yadavprakash/terraform-digitalocean-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_database_firewall.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_firewall) | resource |
| [digitalocean_firewall.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip"></a> [allowed\_ip](#input\_allowed\_ip) | List of allowed IP addresses. | `list(any)` | `[]` | no |
| <a name="input_allowed_ports"></a> [allowed\_ports](#input\_allowed\_ports) | List of allowed ports. | `list(any)` | `[]` | no |
| <a name="input_database_cluster_id"></a> [database\_cluster\_id](#input\_database\_cluster\_id) | ID of the associated database cluster, if applicable. | `string` | `null` | no |
| <a name="input_droplet_ids"></a> [droplet\_ids](#input\_droplet\_ids) | List of Droplet IDs associated with the Firewall. | `list(any)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Flag to indicate whether the Firewall is enabled or not. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., 'prod'). | `string` | `""` | no |
| <a name="input_kubernetes_ids"></a> [kubernetes\_ids](#input\_kubernetes\_ids) | List of Kubernetes IDs associated with the Firewall. | `list(any)` | `[]` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g., 'name', 'application'. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_load_balancer_uids"></a> [load\_balancer\_uids](#input\_load\_balancer\_uids) | List of Load Balancer UIDs associated with the Firewall. | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The Firewall name. | `string` | `""` | no |
| <a name="input_outbound_rule"></a> [outbound\_rule](#input\_outbound\_rule) | List of outbound rules specifying allowed protocols, port ranges, and destination addresses. | <pre>list(object({<br>    protocol              = string<br>    port_range            = string<br>    destination_addresses = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "destination_addresses": [<br>      "0.0.0.0/0",<br>      "::/0"<br>    ],<br>    "destination_droplet_ids": [],<br>    "port_range": "1-65535",<br>    "protocol": "tcp"<br>  },<br>  {<br>    "destination_addresses": [<br>      "0.0.0.0/0",<br>      "::/0"<br>    ],<br>    "port_range": "1-65535",<br>    "protocol": "udp"<br>  }<br>]</pre> | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to be used (e.g., 'tcp', 'udp'). | `string` | `"tcp"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Additional rules or configurations for the Firewall. | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags associated with the Firewall. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | n/a |
| <a name="output_droplet_ids"></a> [droplet\_ids](#output\_droplet\_ids) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_inbound_rule"></a> [inbound\_rule](#output\_inbound\_rule) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_outbound_rule"></a> [outbound\_rule](#output\_outbound\_rule) | n/a |
| <a name="output_status"></a> [status](#output\_status) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
<!-- END_TF_DOCS -->