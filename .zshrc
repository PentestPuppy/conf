# Custom
bright_red="%{$(tput setaf 1; tput bold)%}"
at_sign="%b%F${bright_red}@"
timestamp="%F${bright_red}%D %*%F{%(#.green)}%b]:"
rut="%n"
strt="%F{%(#.green)}┌─["
venv="%F{reset}${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}"
rootat="(%B%F{%(#.cyan)}$rut$at_sign%B%F{%(#.cyan)}$(hostname -I | cut -d ' ' -f 1)%b%F{%(#.green)})-["
tild="%B%F{red}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.green)}]"
veryend="└$venv%F{%(#.green)}─#%F{reset} "


PROMPT="$strt$timestamp$rootat$tild
$veryend"


alias clear='printf "\033c"'
