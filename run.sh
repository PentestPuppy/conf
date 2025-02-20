#!/bin/bash

# Vars
tmux_script='/root/conf/tmux.sh'
tmux_conf='/root/conf/.tmux.conf'
zsh_rc='/root/conf/.zshrc'

printf "\e[1;36m-- . -- . -- APT UPDATE/ UPGRADE \e[m"

cd ~/ && \
apt update -y && \
apt upgrade && sleep 5

printf "\e[1;36m-- . -- . -- MOVE CONF FILES TO ROOT \e[m"

cp "$tmux_conf" '/root'
cat "$zsh_rc" >> '/root/.zshrc'

printf "\e[1;36m-- . -- . -- FINISHED APT, STARTING TMUX INSTALL \e[m"

bash $tmux_script && \
printf "\e[1;36m-- . -- . -- FINISHED TMUX INSTALL"

source '~/.zshrc'

# Set up proj directories
printf "\e[1;36m-- . -- . -- SETTING UP PROJECT DIRS \e[m"
cd /root
mkdir $1
cd $1
mkdir nmap recon web creds cloud

printf "\e[1;36m-- . -- . -- INSTALLING TOOLS \e[m"
# Install tools
# CLOUD
cd /root/$1/cloud
git clone "https://github.com/initstring/cloud_enum.git" && sleep 3
cd cloud_enum
pip install -r requirements.txt && sleep 3

# CREDS
cd /root/$1/creds
# trevorspray
pip install trevorspray && sleep 3

# credmaster
git clone "https://github.com/knavesec/CredMaster.git" && sleep 3
cd CredMaster
pip install -r requirements.txt && sleep 3

# RECON
cd /root/$1/recon
# harvester
git clone https://github.com/laramies/theHarvester.git && sleep 3
cd theHarvester
pip install -r requirements.txt && sleep 3

printf "\e[1;36m-- . -- . -- STARTING TMUX SESSION \e [m"
# Create tmux session
tmux new -t $1
