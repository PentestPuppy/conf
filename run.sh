#!/bin/bash

# Vars
tmux_script='tmux.sh'
tmux_conf='.tmux.conf'
zsh_rc='.zshrc'

printf "\e[1;36m-- . -- . -- APT UPDATE/ UPGRADE \e[m"

cd ~/ && \
apt update -y && \
apt upgrade && \

printf "\e[1;36m-- . -- . -- FINISHED APT, STARTING TMUX INSTALL \e[m"

bash tmux.sh && \
printf "\e[1;36m-- . -- . -- FINISHED TMUX INSTALL"

source ./.zshrc

