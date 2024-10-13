export PATH=$PATH:/root/.go/bin/go

# Custom
bright_red="%{$(tput setaf 1; tput bold)%}"
#bright_red="%{$(tput setaf 1)%}"

PROMPT="%F{%(#.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}[%F${bright_red}$(date +%s)%F{%(#.green)}]:(%B%F{%(#.cyan)}%n㉿%m%b%F{%(#.green)})-[%B%F{red}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.green)}]
└─%(#.${green}#.%F{blue}$)%F{reset} "
