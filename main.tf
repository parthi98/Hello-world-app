provider "google" {
  project = "sixth-window-387009"
  region  = "asia-south2"
}

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true
}

# Create a subnet within the VPC network
resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.name
  region        = "asia-south2"
}

# Create a Cloud SQL instance (MySQL)
#resource "google_sql_database_instance" "sql_instance" {
  #name             = "my-sql-instance"
  #database_version = "MYSQL_8_0"
  #region           = "asia-south2"
  #project          = "sixth-window-387009"

  #settings {
   # tier = "db-n1-standard-2"

    #ip_configuration {
     # ipv4_enabled    = false
   #   private_network = google_compute_network.vpc_network.self_link
  #  }
 # }
#}

# Create a GCE instance
resource "google_compute_instance" "gce_instance" {
  name         = "my-gce-instance"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"
  project      = "sixth-window-387009"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {}
  }

  metadata_startup_script = <<EOF
#!/bin/bash
# Install and configure necessary software on the GCE instance
apt-get update
#apt-get install -y docker.io
apt install apache2 -y

# Start the SQL Auth Proxy as a sidecar container
#docker run -d --name sql-auth-proxy --network host <sql_auth_proxy_image>
EOF
}

# Create a Cloud Load Balancer
#resource "google_compute_global_forwarding_rule" "lb_forwarding_rule" {
#  name       = "my-lb-forwarding-rule"
#  target     = google_compute_target_http_proxy.lb_http_proxy.self_link
#  port_range = "80"
#}

resource "google_compute_http_health_check" "lb_health_check" {
  name                = "my-lb-health-check"
  request_path        = "/"
  check_interval_sec  = 5
  timeout_sec         = 5
  unhealthy_threshold = 2
  healthy_threshold   = 2
}

resource "google_compute_backend_service" "elb" {
  provider = google

  name                  = "backend-service"
  health_checks         = [google_compute_health_check.health_check.id]
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  locality_lb_policy    = "ROUND_ROBIN"
}

resource "google_compute_health_check" "health_check" {
  provider = google

  name = "health-check"
  http_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "lb_url_map" {
  name            = "my-lb-url-map"
  default_service = google_compute_backend_service.elb.self_link
}

resource "google_compute_target_http_proxy" "lb_http_proxy" {
  name    = "lb-http-proxy"
  url_map = google_compute_url_map.lb_url_map.self_link
}

# Establish firewall rules
resource "google_compute_firewall" "firewall" {
  name    = "my-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
	#ingress = ["0.0.0.0/0"]
  }
    source_tags = ["web"]  
}