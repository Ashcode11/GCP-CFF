module "network" {
  source       = "../../modules/network"
  network_name = "dev-vpc"
  subnets = [
    {
      name       = "subnet-1"
      cidr_range = "10.10.0.0/24"
      region     = var.region
    },
    {
      name       = "subnet-2"
      cidr_range = "10.20.0.0/24"
      region     = var.region
    }
  ]
  firewall_rules = [
    {
      name        = "allow-ssh"
      description = "Allow SSH from anywhere"
      protocol    = "tcp"
      ports       = ["22"]
      source_ranges = ["0.0.0.0/0"]
    }
  ]
}
