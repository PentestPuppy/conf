#!/bin/bash

# Courtesy @__Mastodon
#

echo -e "${CYAN}[+] Installing latest Tmux from source... ${C}" && \
apt-get -yqq remove tmux && \
apt-get -yqq install libevent-dev ncurses-dev build-essential bison pkg-config automake && \
git clone https://github.com/tmux/tmux.git /tmp/latest_tmux && cd /tmp/latest_tmux && \
sh autogen.sh && ./configure && make && sudo make install && \
cd /home/trshpuppy/ && \

echo -e "${CYAN}[+] Initializing Tmux configuration... ${C}" && \
mkdir -p /home/trshpuppy/logs/tmux && \
tee /home/trshpuppy/.tmux.conf <<-'EOF' > /dev/null
        set-option -g default-shell /bin/zsh
        set -g @plugin 'tmux-plugins/tmux-logging'
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g history-limit 250000
        set -g allow-rename off
        set -g escape-time 50
        set-window-option -g mode-keys vi
        run '/home/trshpuppy/.tmux/plugins/tpm/tpm'
        run '/home/trshpuppy/.tmux/plugins/tmux-logging/logging.tmux'
        run '/home/trshpuppy/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh'
        bind-key "c" new-window \; run-shell "/home/trshpuppy/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
        bind-key '"' split-window \; run-shell "/home/trshpuppy/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
        bind-key "%" split-window -h \; run-shell "/home/trshpuppy/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh"
EOF
echo -e "${CYAN}[+] Installing the Tmux Plugin Manager (TPM)... ${C}" && \
rm -rf /home/trshpuppy/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm.git /home/trshpuppy/.tmux/plugins/tpm && \
/bin/bash /home/trshpuppy/.tmux/plugins/tpm/scripts/install_plugins.sh && \
sed -i 's/default_logging_path="$HOME"/default_logging_path="\/home/trshpuppy\/logs\/tmux"/' /home/trshpuppy/.tmux/plugins/tmux-logging/scripts/variables.sh && \
tmux new-session -d; # initialize tmux
tmux source-file /home/trshpuppy/.tmux.conf && \
gem install tmuxinator && \
mkdir -p /home/trshpuppy/.config/tmuxinator && \
tee /home/trshpuppy/.config/tmuxinator/default.yml <<-'EOF' > /dev/null
        name: default
        root: ~/
        windows:
            - main: tmux source /home/trshpuppy/.tmux.conf
            - msf: msfconsole
EOF

