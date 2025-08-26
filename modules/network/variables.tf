variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name       = string
    cidr_range = string
    region     = string
  }))
}

variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    name          = string
    description   = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
  }))
  default = []
}
