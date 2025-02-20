#!/bin/bash

# Vars
tmux_script='/root/conf/tmux.sh'
tmux_conf='/root/conf/.tmux.conf'
zsh_rc='/root/conf/.zshrc'

printf "\e[1;36m-- . -- . -- APT UPDATE/ UPGRADE \e[m"

cd ~/ && \
apt update -y && \
apt upgrade && \

printf "\e[1;36m-- . -- . -- MOVE CONF FILES TO ROOT \e[m"

cp "$tmux_conf" '/root'
cat "$zsh_rc" >> '/root/.zshrc'

printf "\e[1;36m-- . -- . -- FINISHED APT, STARTING TMUX INSTALL \e[m"

bash $tmux_script && \
printf "\e[1;36m-- . -- . -- FINISHED TMUX INSTALL"

source '~/.zshrc'

# Set up proj directories
cd /root
mkdir $1
cd $1
mkdir nmap recon web creds cloud

# Create tmux session
tmux new -t $1
