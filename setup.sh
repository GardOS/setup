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
software-properties-common \
unzip

#ZSH
sudo apt-get install zsh
sudo chsh -s $(which zsh)
sudo usermod -s $(which zsh) gardo1506
echo export DISPLAY=:0 >> ~/.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "#Custom\nDEFAULT_USER=`whoami`" >> ~/.zshrc
sed -i -e 's/"robbyrussell"/"agnoster"/g' ~/.zshrc

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

#Setup
cd ~/tools
git clone https://github.com/GardOS/setup.git
cd ~ 

#Git
git config --global user.email "Gardo1506@gmail.com"
git config --global user.name "GardOS"
git config --global credential.helper 'cache --timeout 7200'

#Gnome-terminal
sudo apt-get install -y gnome-terminal

sudo sh -c "echo '[Desktop Entry]
Name=GnomeTerminal
Comment=Use the command line
Keywords=shell;prompt;command;commandline;cmd;
TryExec=gnome-terminal
Exec=gnome-terminal
Icon=utilities-terminal
Type=Application
X-GNOME-DocPath=gnome-terminal/index.html
X-GNOME-Bugzilla-Bugzilla=GNOME
X-GNOME-Bugzilla-Product=gnome-terminal
X-GNOME-Bugzilla-Component=BugBuddyBugs
X-GNOME-Bugzilla-Version=3.28.2
Categories=GNOME;GTK;System;TerminalEmulator;
StartupNotify=true
X-GNOME-SingleWindow=false' >> /usr/share/applications/gnome-terminal.desktop"

#VSCode
curl -L https://go.microsoft.com/fwlink/?LinkID=760868 > vscode.deb
sudo apt install -y ./vscode.deb
rm vscode.deb
sudo sh -c "echo 'deb http://deb.debian.org/debian stretch main contrib
deb http://security.debian.org/debian-security stretch/updates main contrib
deb [arch=amd64] https://download.docker.com/linux/debian stretch stable contrib
# deb-src [arch=amd64] https://download.docker.com/linux/debian stretch stable' >> /etc/apt/sources.list"

sudo apt-get update
sudo apt-get install -y fonts-firacode

#Nvm, Node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh
. ~/.nvm/nvm.sh
. ~/.profile
. ~/.zshrc
nvm install node

#Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" install yarn -y

#IntelliJ
cd tools
wget https://download.jetbrains.com/idea/ideaIU-2018.2.3.tar.gz
tar xzvf ~/tools/ideaIU-2018.2.3.tar.gz 
rm ~/tools/ideaIU-2018.2.3.tar.gz
sudo sh -c "echo '[Desktop Entry]
Version=13.0
Type=Application
Terminal=false
Icon[en_US]=/home/gardo1506/.IntelliJIdea2018.2/bin/idea.png
Name[en_US]=IntelliJ
Exec=/home/gardo1506/.IntelliJIdea2018.2/bin/idea.sh
Name=IntelliJ
Icon=/home/gardo1506/.IntelliJIdea2018.2/bin/idea.png' >> /usr/share/applications/intellij.desktop"

sudo chmod 644 /usr/share/applications/intellij.desktop
sudo chown root:root /usr/share/applications/intellij.desktop

#SDK
curl -s "https://get.sdkman.io" | zsh
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install springboot
sdk install java
sdk install maven

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

#Terraform
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
unzip terraform_0.11.8_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#Heroku
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

#Crostini - Sommelier
mkdir -p ~/.config/systemd/user
   
cp -r /etc/systemd/user/sommelier@0.service.d \
	/etc/systemd/user/sommelier-x@0.service.d \
	~/.config/systemd/user/

sed -i -e 's/Environment="SOMMELIER_ACCELERATORS=Super_L"/Environment="SOMMELIER_ACCELERATORS=Super_L,<Alt>bracketright,<Alt>bracketleft,<Alt>equal,<Alt>minus"/g' ~/.config/systemd/user/sommelier-x@0.service.d/cros-sommelier-x-override.conf

sed -i -e 's/Environment="SOMMELIER_ACCELERATORS=Super_L"/Environment="SOMMELIER_ACCELERATORS=Super_L,<Alt>bracketright,<Alt>bracketleft,<Alt>equal,<Alt>minus"/g' ~/.config/systemd/user/sommelier@0.service.d/cros-sommelier-override.conf

#Finalize and verify
sudo apt-get update -y
clear

code -v
nvm --version
node -v
npm -v
sdk version
spring --version
java -version
mvn -v
docker -v
docker-compose -v
terraform -v
heroku -v
zsh --version

#Manual steps
: '
systemctl --user daemon-reload
systemctl --user restart sommelier@0.service
systemctl --user restart sommelier-x@0.service
'
