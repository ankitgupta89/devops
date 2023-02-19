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
fi
deploymentname=$1;
# export vmname
# echo $vmname;
# mydate=$(date +%Y%m%d);
# echo $mydate;
# echo $vmname;
gcloud deployment-manager deployments create $deploymentname --config jupyter.yaml
