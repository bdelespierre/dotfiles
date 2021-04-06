
# -----------------------------------------------------------------------------
# ONE CHAR
# -----------------------------------------------------------------------------
#
alias c='composer'
alias e='echo -e'
alias g='git'
alias h='history | tail -n 10'
alias j='jobs'
alias l='ll'
alias p='/usr/bin/env php'
alias t='tmux'
alias v='vim'
alias ?='aliases'

# -----------------------------------------------------------------------------
# LS
# -----------------------------------------------------------------------------
#
alias ll='ls -lhF --color --group-directories-first'
alias la='ll -A'

# -----------------------------------------------------------------------------
# GREP
# -----------------------------------------------------------------------------
#
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# -----------------------------------------------------------------------------
# TMUX
# -----------------------------------------------------------------------------
#
alias ta='tmux a -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias tequila='tmux ls | grep : | cut -d: -f1 | xargs tmux kill-session -t'

# -----------------------------------------------------------------------------
# APACHE
# -----------------------------------------------------------------------------
#
alias a2='sudo systemctl status apache2'
alias a2start='sudo systemctl start apache2'
alias a2reload='sudo systemctl reload apache2'
alias a2restart='sudo systemctl restart apache2'
alias a2stop='sudo systemctl stop apache2'
alias a2log='tail -F /var/log/apache2/*.log'

# -----------------------------------------------------------------------------
# MYSQL
# -----------------------------------------------------------------------------
#
alias my='mysql'

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------
#
alias lint='find . -path ./vendor -prune -o -name "*.php" -print0 | xargs -0 -n1 -P8  php -l > /dev/null'
alias pa='php artisan'
alias pu='vendor/bin/phpunit --stop-on-error --stop-on-failure --colors'
alias puf='pu --filter'
alias tinker='php artisan tinker'
alias serve='php artisan serve >/dev/null 2>&1 &'
alias logs='tail -F storage/logs/laravel.log'
# sudo update-alternatives --config php
# sudo composer --self-update --1

# -----------------------------------------------------------------------------
# PYTHON
# -----------------------------------------------------------------------------
#
alias py='python3'

# -----------------------------------------------------------------------------
# DOCKER
# -----------------------------------------------------------------------------
#
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcd='docker-compose up --build -d'

# -----------------------------------------------------------------------------
# HEROKU
# -----------------------------------------------------------------------------
#
alias hlog='heroku logs'
alias hrun='heroku run'
alias hbuild='heroky buildpacks'

# -----------------------------------------------------------------------------
# AWK
# -----------------------------------------------------------------------------
#
alias col1="awk '{print \$1}'"
alias col2="awk '{print \$2}'"
alias col3="awk '{print \$3}'"
alias col4="awk '{print \$4}'"
alias col5="awk '{print \$5}'"

# -----------------------------------------------------------------------------
# MISC
# -----------------------------------------------------------------------------
#
alias aliases='cat ~/.bash_aliases | grep -vE "^#" | sed -e "s/alias //" -e "/^\s*$/d" | sort'
alias less='less -r'
alias path='echo $PATH | sed -e "s/:/\n/g" -e "s|${HOME}|~|g"'
alias lurk-more='history -c && clear && printf "\e[3J"'
alias py-serve='python3 -m http.server 8080'
alias clock='while sleep 0.5;do tput sc;tput cup 0 $(($(tput cols)-10)); tput setaf 7; date +"[%T]";tput rc;done &'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tree='ls -R | grep ":$" |sed -e "s/:$//" -e "s/[^-][^\/]*\//--/g" -e "s/^/   /" -e "s/-/|/"'
alias favs='history | awk '\''{a[$2]++}END{for(i in a){print a[i] " " i}}'\'' | sort -rn | head'
