
# -----------------------------------------------------------------------------
# ONE CHAR
# -----------------------------------------------------------------------------
#
alias c='composer'
alias d='docker'
alias e='echo -e'
alias g='git'
alias h='history | tail -n 10'
alias j='jobs'
alias l='ll'
alias n='npm'
alias p='/usr/bin/env php'
alias t='tmux'
alias v='vim'
alias y='yarn'

# -----------------------------------------------------------------------------
# LS
# -----------------------------------------------------------------------------
#
export COLUMNS  # Remember columns for subprocesses.
function ls {
    command ls \
        -Fhv \
        --color \
        --group-directories-first \
        --time-style=long-iso \
        -C "$@" \
    | less -RXF
}

alias ll='ls -l'
alias la='ll -A'

# -----------------------------------------------------------------------------
# GREP
# -----------------------------------------------------------------------------
#
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# -----------------------------------------------------------------------------
# RM
# -----------------------------------------------------------------------------
#
function rm {
    command rm -v "$@" | less -RXF
}

# -----------------------------------------------------------------------------
# NOTIFY
# -----------------------------------------------------------------------------
#
function notify {
    $@

    if [[ $? == 0 ]]; then
        local icon="terminal"
    else
        local icon="error"
    fi

    notify-send -i $icon "$1" "${2:-No message}"
}

# -----------------------------------------------------------------------------
# GROUPS
# -----------------------------------------------------------------------------
#
function add-user-to-group { #(user, group)
    sudo usermod -aG "$2" "$1"
}

function remove-user-from-group { #(user, group)
    sudo gpasswd -d "$1" "$2"
}

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
alias a2do="sudo runuser -u www-data --"

# -----------------------------------------------------------------------------
# MYSQL
# -----------------------------------------------------------------------------
#
alias my='mysql'

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------
#
function find-usage {
    git grep -C2 -p -E "(-[>]|::)$1\("
}

function composer-query {
    jq ".$1" "composer.json"
}

function php-execute {
    # check if docker
    # run
    false
}

alias fu='find-usage'
alias cq='composer-query'
alias lint='find . -path ./vendor -prune -o -name "*.php" -print0 | xargs -0 -n1 -P8  php -l > /dev/null'
alias pa='php artisan'
alias pu='vendor/bin/phpunit --stop-on-error --stop-on-failure --colors'
alias puf='pu --filter'
alias tinker='php artisan tinker --ansi'
alias serve='php artisan serve >/dev/null 2>&1 &'
alias logs='tail storage/logs/laravel.log'
alias change-php-version='sudo update-alternatives --config php'
alias fix='phpcbf --standard=psr12'
alias check='phpcs --standard=psr12'
alias fpm-restart='sudo systemctl restart php8.0-fpm.service'
alias px='php-execute'

# -----------------------------------------------------------------------------
# JavaScript
# -----------------------------------------------------------------------------
#
alias npm-build='npm run build'
alias npm-install-defaults='npm install --global jslint rollup'
alias change-node-version='nvm list' # then nvm use <version>

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
function default {
    local output=$(eval "$@" 2>&1)
    echo -e "${output:-\e[90mNo output\e[0m}"
}

function for-each-dir {
    for dir in */; do
        cd $dir
        echo -e "\n\e[0;33m$(pwd)\e[0m"
        $@
        cd ..
    done
}
alias bat='batcat'
alias clock='while sleep 0.5;do tput sc;tput cup 0 $(($(tput cols)-10)); tput setaf 7; date +"[%T]";tput rc;done &'
alias favs='history | awk '\''{a[$2]++}END{for(i in a){print a[i] " " i}}'\'' | sort -rn | head'
alias fed='for-each-dir'
alias lurk-more='history -c && clear && printf "\e[3J"'
alias path='echo $PATH | sed -e "s/:/\n/g" -e "s|${HOME}|~|g"'
alias py-serve='python3 -m http.server 8080'
