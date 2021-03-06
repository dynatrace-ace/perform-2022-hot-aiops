################################
#      SETUP 0                 #
################################

echo "############# SETUP 0 #############"
############   COPY FOLDER        ###########
echo "COPY FOLDER"
cp -R /home/$shell_user/perform-2022-hot-aiops/repos /home/$shell_user/

############## INSTALL REQUIRED PACKAGES  ##############
echo "installing JQ"
sudo apt-get -q install jq -y 

echo "Installing packages"
apt-get -q update -y 
apt-get -q install -y git vim jq build-essential software-properties-common default-jdk libasound2 libatk-bridge2.0-0 \
 libatk1.0-0 libc6:amd64 libcairo2 libcups2 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libnss3 libxss1 xdg-utils \
 libminizip-dev libgbm-dev libflac8 apache2-utils 
add-apt-repository --yes --update ppa:ansible/ansible
apt-get -q update -y 
apt-get -q install -y ansible
apt install docker.io -y
echo '{
"log-driver": "json-file",
"log-opts": {
  "max-size": "10m",
  "max-file": "3"
  }
}' > /etc/docker/daemon.json
service docker start
usermod -a -G docker $shell_user
wget https://github.com/mikefarah/yq/releases/download/v4.15.1/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq


############   EXPORT VARIABLES   ###########
echo "input variables"
echo $DT_ENV_URL
echo $DT_CLUSTER_TOKEN
echo $shell_user
echo $shell_password
echo $PROGRESS_CONTROL

export DT_ENV_URL=$DT_ENV_URL
export DT_CLUSTER_TOKEN=$DT_CLUSTER_TOKEN
export shell_user=$shell_user
export shell_password=$shell_password
export PROGRESS_CONTROL=$PROGRESS_CONTROL

echo "export DT_ENV_URL=$DT_ENV_URL" >> /home/$shell_user/.bashrc
echo "export shell_user=$shell_user" >> /home/$shell_user/.bashrc
echo "export shell_password=$shell_password" >> /home/$shell_user/.bashrc
echo "export PROGRESS_CONTROL=$PROGRESS_CONTROL" >> /home/$shell_user/.bashrc

###################################
#  Set user and file permissions  #
###################################

echo "Configuring environment for user $shell_user"
chown -R $shell_user:$shell_user /home/$shell_user/.* /home/$shell_user/*
chmod -R 755 /home/$shell_user/.* /home/$shell_user/*
runuser -l $shell_user -c 'git config --global user.email $git_email && git config --global user.name $git_user && git config --global http.sslverify false'


###########  Part 1  ##############
if [ "$PROGRESS_CONTROL" -gt "1" ]; then
    /home/$shell_user/perform-2022-hot-aiops/install/setup-1.sh
fi
