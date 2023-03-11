sudo apt-get update && sudo apt-get install ansible -y
git clone https://github.com/ankitgupta89/devops.git
service_account_email=`gcloud iam service-accounts list | grep EMAIL | grep cli-service | awk '{ print $2 }'`
gcloud iam service-accounts keys create devops/gcp/ansible/creds.json --iam-account $service_account_email
ansible-playbook devops/gcp/ansible/rhel_vm.yaml