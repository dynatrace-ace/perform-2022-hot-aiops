#!/usr/bin/env bash
################################
#      SETUP 5 -AWX            #
################################
echo "############### SETUP 5 - AWX ###########################"
#########################################
#  VARIABLES                            #
#########################################
echo "Starting installation"
keptn_version=0.11.4
domain="nip.io"
source_repo="https://github.com/dynatrace-ace/perform-2022-hot-aiops.git"
clone_folder=perform-2022-hot-aiops

ansible_operator_version=0.13.0
login_user="admin"
login_password="dynatrace"
git_org="perform"
git_repo="auto-remediation"
git_user="dynatrace"
git_password="dynatrace"
git_email="ace@ace.ace"
USER="ace"
DT_CREATE_ENV_TOKENS=true

######################################
#   INSTALL + CONFIGURE ANSIBLE AWX  #
######################################

echo "Deploy Ansible AWX"
AWX_NAMESPACE=awx
kubectl apply -f - <<EOF
---
kind: Namespace
apiVersion: v1
metadata:
  name: $AWX_NAMESPACE
EOF
# create awx admin secret
kubectl apply -f - <<EOF
---
apiVersion: v1
kind: Secret
metadata:
  name: awx-aiops-admin-password
  namespace: $AWX_NAMESPACE
stringData:
  password: $login_password
EOF
kubectl apply -f https://raw.githubusercontent.com/ansible/awx-operator/$ansible_operator_version/deploy/awx-operator.yaml
kubectl rollout status deploy/awx-operator
kubectl apply -f - <<EOF
---
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx-aiops
  namespace: $AWX_NAMESPACE
spec:
  service_type: ClusterIP
  ingress_type: ingress
  hostname: awx.$ingress_domain
EOF
sleep 10
kubectl -n $AWX_NAMESPACE rollout status deployment/awx-aiops
# echo "CREATING USER FOR ANSIBLE"
# sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# ansibleuser="ansiblesa"
# sudo useradd -m $ansibleuser
# sudo usermod -aG sudo $ansibleuser
# randompass=$(date +%s | sha256sum | base64 | head -c 32)
# echo $randompass
# echo $ansibleuser:$randompass| sudo chpasswd
# sudo service ssh restart
# su $ansibleuser
echo "Running playbook to configure AWX"
ansible-playbook /tmp/awx_config.yml --extra-vars="awx_url=http://awx.$ingress_domain ingress_domain=$ingress_domain awx_admin_username=$login_user dt_environment_url=$DT_ENV_URL \
  dynatrace_api_token=$DT_API_TOKEN custom_domain_protocol=http shell_user=$shell_user shell_password=$shell_password keptn_api_token=$KEPTN_API_TOKEN"


############   EXPORT VARIABLES   ###########
echo "export variables"
export AWX_NAMESPACE=$AWX_NAMESPACE

###########  Part 6  ##############
/home/$USER/install/setup-6.sh