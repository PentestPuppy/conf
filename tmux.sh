#!/bin/bash

# Courtesy @__Mastodon
#
echo 'Installing ruby'
apt-get install ruby-full && \

echo -e "${CYAN}[+] Installing latest Tmux from source... ${C}" && \
apt-get -yqq remove tmux && \
apt-get -yqq install libevent-dev ncurses-dev build-essential bison pkg-config automake && \
git clone https://github.com/tmux/tmux.git /tmp/latest_tmux && cd /tmp/latest_tmux && \
sh autogen.sh && ./configure && make && make install && \
cd /root/ && \

echo -e "${CYAN}[+] Initializing Tmux configuration... ${C}" && \
mkdir -p /root/logs/tmux && \
tee /root/.tmux.conf <<-'EOF' > /dev/null
        set-option -g default-shell /bin/zsh
        set -g @plugin 'tmux-plugins/tmux-logging'
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g history-limit 250000
        set -g allow-rename off
        set -g escape-time 50
        set-window-option -g mode-keys vi
        run '/root/.tmux/plugins/tpm/tpm'
        run '/root/.tmux/plugins/tmux-logging/logging.tmux'
        run '/root/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh'
        bind-key "c" new-window \; run-shell "/root/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
        bind-key '"' split-window \; run-shell "/root/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
        bind-key "%" split-window -h \; run-shell "/root/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
EOF
echo -e "${CYAN}[+] Installing the Tmux Plugin Manager (TPM)... ${C}" && \
rm -rf /root/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm.git /root/.tmux/plugins/tpm && \
/bin/bash /root/.tmux/plugins/tpm/scripts/install_plugins.sh && \
sed -i 's/default_logging_path="$HOME"/default_logging_path="\/root\/logs\/tmux"/' /root/.tmux/plugins/tmux-logging/scripts/variables.sh && \
tmux new-session -d; # initialize tmux
tmux source-file /root/.tmux.conf && \
gem install tmuxinator && \
mkdir -p /root/.config/tmuxinator && \
tee /root/.config/tmuxinator/default.yml <<-'EOF' > /dev/null
        name: default
        root: ~/
        windows:
            - main: tmux source /root/.tmux.conf
            - msf: msfconsole
EOF
