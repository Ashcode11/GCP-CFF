output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnets" {
  value = [for s in google_compute_subnetwork.subnets : s.name]
}
