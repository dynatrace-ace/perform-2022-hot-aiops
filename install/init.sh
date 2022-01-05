echo "getting vm ready"
#########################################
# PRE SETUP                              #
#########################################
echo "UPDATING REPO"
apt-get update -y 
apt-get install -y -q git vim jq build-essential software-properties-common default-jdk libasound2 libatk-bridge2.0-0 \
 libatk1.0-0 libc6:amd64 libcairo2 libcups2 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libnss3 libxss1 xdg-utils \
 libminizip-dev libgbm-dev libflac8 apache2-utils

apt-get --qq dist-upgrade -y 
apt-get -q -f install
sudo apt --qq install git -y
echo "CLONING REPO"
git clone -q https://github.com/dynatrace-ace/perform-2022-hot-aiops.git
sudo chmod +x -R ./perform-2022-hot-aiops/install
sudo DT_ENV_URL=$DT_ENV_URL DT_CLUSTER_TOKEN=$DT_CLUSTER_TOKEN shell_user=$shell_user shell_password=$shell_password ./perform-2022-hot-aiops/install/setup-0.sh