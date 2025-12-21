# Terraform Docker Monitoring Lab (NGINX + Prometheus + Grafana)

## Overview
This project demonstrates Infrastructure as Code (IaC) principles using Terraform to provision and manage a containerized monitoring stack using Docker, Nginx, Prometheus, and Grafana for visual data.

The lab simulates an enterprise real-world IaC environment, focusing on:
- Declarative infrastructure
- Service networking
- Metrics collection and visualization
- Persistent storage
- Operational troubleshooting

## Architecture
- **Nginx** – Sample web service
- **Prometheus** – Metrics collection and scraping
- **Node Exporter** – Host-level metrics
- **Grafana** – Metrics visualization/dashboards
- **Docker Network** – Isolated monitoring network
- **Terraform** – IaC Infrastructure resource Provisioning


Technologies Used
Terraform 
Docker Engine
Prometheus
Grafana
Linux (WSL2 / AlmaLinux )

Key Features
Docker images and containers managed entirely by Terraform
Custom NGINX image built via Dockerfile
Persistent volumes for Prometheus data and configuration
Service discovery via Docker networking
Grafana provisioning with admin credentials via environment variables
Clean teardown using terraform destroy

**How to Run**
terraform init
terraform apply

**Access Services**
NGINX: http://localhost:8081
Prometheus: http://localhost:9090
Grafana: http://localhost:3000

**Lessons Learned**
Debugging container startup failures

Handling Docker permissions and volume ownership

Prometheus scrape configuration and networking

Terraform resource dependency management

**==Future Improvements==**
Alertmanager integration
TLS with reverse proxy
Remote backend (S3 + DynamoDB)
Staging for Java and Python Application hosting
Multi-Could Multi-Tenant CI/CD pipeline
Kubernetes migration


