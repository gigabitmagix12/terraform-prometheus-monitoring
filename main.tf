                                                                                                               terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "monitoring" {
  name = "monitoring"
}

# ---------- NGINX IMAGE ----------
resource "docker_image" "custom_nginx" {
  name = "custom-nginx:1.0"

  build {
    context = "${path.module}/site"
  }
}

# ---------- NGINX CONTAINER ----------
resource "docker_container" "nginx" {
  name  = "tf-nginx"
  image = docker_image.custom_nginx.name

  networks_advanced {
    name = docker_network.monitoring.name
  }

  volumes {
    host_path      = "/home/charles/tf-nginx/site"
    container_path = "/usr/share/nginx/html"
  }

  ports {
    internal = 80
    external = 8081
  }
}

# ---------- PROMETHEUS IMAGE ----------
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

# ---------- PROMETHEUS CONTAINER ----------
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.name

  networks_advanced {
    name = docker_network.monitoring.name
  }

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = "/home/charles/tf-nginx/monitoring/prometheus"
    container_path = "/etc/prometheus"
  }

  volumes {
    host_path      = "/home/charles/tf-nginx/data/prometheus"
    container_path = "/prometheus"
  }

  command = [
    "--config.file=/etc/prometheus/prometheus.yml",
    "--storage.tsdb.path=/prometheus"
  ]
}

# ---------- GRAFANA CONTAINER  ----------
resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana:latest"

  networks_advanced {
    name = docker_network.monitoring.name
  }

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "GF_SECURITY_ADMIN_USER=admin",
    "GF_SECURITY_ADMIN_PASSWORD=supersecretpassword",
    "GF_USERS_ALLOW_SIGN_UP=false"
  ]

  volumes {
    host_path      = "/home/charles/tf-nginx/data/grafana"
    container_path = "/var/lib/grafana"

  }
}
