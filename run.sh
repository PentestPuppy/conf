#!/bin/bash

# Vars
tmux_script='~/conf/tmux.sh'
tmux_conf='~/conf/.tmux.conf'
zsh_rc='~/conf.zshrc'

printf "\e[1;36m-- . -- . -- APT UPDATE/ UPGRADE \e[m"

cd ~/ && \
apt update -y && \
apt upgrade && \

printf "\e[1;36m-- . -- . -- MOVE CONF FILES TO ROOT \e[m"

cp $tmux_conf ~/
cp $zsh_rc ~/

printf "\e[1;36m-- . -- . -- FINISHED APT, STARTING TMUX INSTALL \e[m"

bash $tmux_script && \
printf "\e[1;36m-- . -- . -- FINISHED TMUX INSTALL"

source ~/.zshrc

