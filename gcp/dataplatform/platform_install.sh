#!/bin/bash
### Installing Docker
sudo su -
yum install -y docker

## Download and run hive docker image
export HIVE_VERSION=4.0.0-alpha-2
docker run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hive4 docker.io/apache/hive:4.0.0-alpha-2
export externalip=`curl http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google"`
docker run --name nifi -p 8443:8443 -d -e NIFI_WEB_PROXY_HOST=$externalip:8443 -e NIFI_WEB_HTTPS_PORT='8443' docker.io/apache/nifi:latest

## Install python38
yum install -y python38
python3.8 -m venv /opt/airflow_venv
source /opt/airflow_venv/bin/activate

## Install Airflow
AIRFLOW_VERSION=2.5.1
PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-no-providers-${PYTHON_VERSION}.txt"
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
airflow db upgrade
deactivate

## Install Anaconda (it already contains jupyter)
curl -O https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
bash Anaconda3-2022.10-Linux-x86_64.sh -b -p /opt/anaconda3

## Start jupyter notebook
source /opt/anaconda3/bin/activate
jupyter notebook --generate-config
cat >> /root/.jupyter/jupyter_notebook_config.py << EOL
c = get_config()
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8082
EOL