#/bin/bash

### Checking arguments. 

if [ $# -eq 0 ];
then
  echo "$0: Missing arguments. Usage: deploy.sh [unique_deployment_name]"
  exit 1
elif [ $# -gt 1 ];
then
  echo "$0: Too many arguments: $@"
  exit 1
fi
deploymentname=$1;
cd "$(dirname "$0")"
gcloud deployment-manager deployments create $deploymentname --config airflow.yaml
