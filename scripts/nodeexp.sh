#!/bin/bash
set -e
 
echo "=============================="
echo " Prometheus Setup Script"
echo "=============================="
 
# Update system
sudo apt update -y
 
# Create a dedicated system user for Prometheus
sudo useradd --system --no-create-home --shell /bin/false prometheus
 
# Download and extract Prometheus
PROM_VERSION="2.47.1"
wget "https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz"
tar -xvf "prometheus-${PROM_VERSION}.linux-amd64.tar.gz"
 
# Set up directories
sudo mkdir -p /data /etc/prometheus
cd "prometheus-${PROM_VERSION}.linux-amd64/"
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/
 
cd ..
rm -rf "prometheus-${PROM_VERSION}.linux-amd64.tar.gz" "prometheus-${PROM_VERSION}.linux-amd64"
prometheus --version

