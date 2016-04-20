
# -----------------------------------------------------------------------------
# ONE CHAR
# -----------------------------------------------------------------------------

alias b='bower'
alias c='composer'
alias e='echo -e'
alias g='git'
alias h='history | tail -n 10'
alias j='jobs'
alias l='ls -lhF --color --group-directories-first'
alias m='mysql -h localhost -p'
alias n='node'
alias p='php5'
alias t='tmux'
alias v='vim'

# -----------------------------------------------------------------------------
# LS
# -----------------------------------------------------------------------------

alias ll='l'
alias la='l -A'

# -----------------------------------------------------------------------------
# GREP
# -----------------------------------------------------------------------------

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# -----------------------------------------------------------------------------
# GIT
# -----------------------------------------------------------------------------

alias git-current-branch='git rev-parse --abbrev-ref HEAD'
alias gcb='git-current-branch'

# -----------------------------------------------------------------------------
# TMUX
# -----------------------------------------------------------------------------

alias ta='tmux a -t'
alias tn='tmux new -s'
alias tls='tmux ls'

# -----------------------------------------------------------------------------
# PHP
# -----------------------------------------------------------------------------

alias lint='find . -name "*.php" -print0 | xargs -0 -n1 -P8  php -l | grep -v "No syntax errors detected"'

# -----------------------------------------------------------------------------
# VAGRANT
# -----------------------------------------------------------------------------

alias vagrant-restart='cd ~/Workspace/puppetmaster-mrd && vagrant halt && vagrant up && cd -'
alias vagrant-fpm-restart='ssh ma-residence.dev sudo service php5-fpm restart'

# -----------------------------------------------------------------------------
# MISC
# -----------------------------------------------------------------------------

alias ..='cd ..'
alias -- -='cd -'
alias less='less -R'
alias path='echo $PATH | sed -e "s/:/\n/g" -e "s|${HOME}|~|g"'
alias lurk-more='history -c && clear && printf "\e[3J"'
alias serve='python -m SimpleHTTPServer'
alias wclone='wget --random-wait -r -p -b -S -k -e robots=off -U mozilla -a /tmp/wclone.log --limit-rate=100k'
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-10)); tput setaf 7; date +"[%T]";tput rc;done &'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
