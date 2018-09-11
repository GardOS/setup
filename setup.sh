#!/bin/sh

#Note: Links might expire

#Meta
sudo apt-get update -y
sudo apt-get install -y \
wget \
apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common

#File structure
mkdir div
mkdir downloads
mkdir temp
mkdir tools
mkdir school
mkdir school/web
mkdir school/devops

#School
cd ~/school/web
git clone https://github.com/arcuri82/pg6300.git

cd ~/school/devops
git clone https://github.com/glennbech/PGR301.git
git clone https://github.com/GardOS/DevOps-Exercise.git
wget https://raw.githubusercontent.com/starkandwayne/concourse-tutorial/master/docker-compose.yml
cd ~

#VSCode
curl -L https://go.microsoft.com/fwlink/?LinkID=760868 > vscode.deb
sudo apt install -y ./vscode.deb
rm vscode.deb

#Nvm, Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
. ~/.nvm/nvm.sh
. ~/.profile
. ~/.bashrc
nvm install node

#IntelliJ, Java, Maven
cd tools
wget https://download.jetbrains.com/idea/ideaIU-2018.2.3.tar.gz
tar xzvf ~/tools/ideaIU-2018.2.3.tar.gz 
rm ~/tools/ideaIU-2018.2.3.tar.gz
sudo apt-get install -y default-jdk
sudo apt-get install -y maven

#Docker, Docker-compose
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get -y update
sudo apt-get -y install docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Finalize and verify
sudo apt-get update -y
clear

code -v
nvm -v
node -v
npm -v
java -version
mvn -v
docker -v
docker-compose -v

#Manual steps
:'
Restart
crosh: 
    vmc stop termina 
    vmc start termina
    lxc profile unset default security.syscalls.blacklist && lxc profile apply penguin default

sudo docker run hello-world
~/tools/idea-IU-182.4323.46/bin/idea.sh &
code ~/school 
cd ~/school/devops && docker-compose up -d
'