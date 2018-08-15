
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
alias m='mysql -h localhost -p'
alias n='node'
alias p='/usr/bin/env php'
alias t='tmux'
alisa y='yokadi --'
alias v='vim'

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
# GIT
# -----------------------------------------------------------------------------

alias git-current-branch='git rev-parse --abbrev-ref HEAD'
alias gcb='git-current-branch'
alias gpu='git pull upstream `git-current-branch`'
alias gru='git remote update && git reset --hard upstream/`git-current-branch`'

# -----------------------------------------------------------------------------
# TMUX
# -----------------------------------------------------------------------------
#
alias ta='tmux a -t'
alias tn='tmux new -s'
alias tls='tmux ls'
alias tequila='tmux ls | grep : | cut -d: -f1 | xargs tmux kill-session -t'

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------
#
alias lint='find . -name "*.php" -print0 | xargs -0 -n1 -P8  php -l | grep -v "No syntax errors detected"'
alias pa='php artisan'
alias tinker='php artisan tinker'

# -----------------------------------------------------------------------------
# VAGRANT
# -----------------------------------------------------------------------------
#
alias vagrant-restart='cd ~/Workspace/puppetmaster-mrd && vagrant halt && vagrant up && cd -'
alias vagrant-fpm-restart='ssh ma-residence.dev sudo service php5-fpm restart'

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
# MISC
# -----------------------------------------------------------------------------
#
alias ..='cd ..'
alias -- -='cd -'
alias less='less -R'
alias path='echo $PATH | sed -e "s/:/\n/g" -e "s|${HOME}|~|g"'
alias lurk-more='history -c && clear && printf "\e[3J"'
alias serve='python -m SimpleHTTPServer'
alias wclone='wget --random-wait -r -p -b -S -k -e robots=off -U mozilla -a /tmp/wclone.log --limit-rate=100k'
alias clock='while sleep 0.5;do tput sc;tput cup 0 $(($(tput cols)-10)); tput setaf 7; date +"[%T]";tput rc;done &'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias clipboard='xsel --clipboard'
