#/bin/bash
# Author: Ankit
# Install docker on the VM
# Run nifi image with external IP added as accepted HTTPS header i.e. NIFI_WEB_PROXY_HOST

sudo su 
yum install -y docker
export externalip=`curl http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google"`
docker run --name nifi -p 8443:8443 -d -e NIFI_WEB_PROXY_HOST=$externalip:8443 -e NIFI_WEB_HTTPS_PORT='8443' docker.io/apache/nifi:latest
