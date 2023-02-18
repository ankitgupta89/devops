#/bin/bash

### Checking arguments. 

if [ $# -eq 0 ];
then
  echo "$0: Missing arguments"
  exit 1
elif [ $# -gt 1 ];
then
  echo "$0: Too many arguments: $@"
  exit 1
vmname=$0
mydate=$(date)
deploymentname="${vmname}_${mydate}_deployment"
echo $vmname
gcloud deployment-manager deployments create $deploymentname --config jupyter.yaml
