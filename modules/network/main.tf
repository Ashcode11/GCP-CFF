variable "network_name" { type = string }
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

# VPC
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

# Subnets
resource "google_compute_subnetwork" "subnets" {
  for_each       = { for s in var.subnets : s.name => s }
  name           = each.value.name
  ip_cidr_range  = each.value.cidr_range
  region         = each.value.region
  network        = google_compute_network.vpc.id
}

# Firewall
resource "google_compute_firewall" "rules" {
  for_each    = { for r in var.firewall_rules : r.name => r }
  name        = each.value.name
  network     = google_compute_network.vpc.name
  description = each.value.description

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }

  source_ranges = each.value.source_ranges
}
