export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

alias ls='ls -G'
alias c='clear'
alias server='python -m SimpleHTTPServer'
alias nrs='npm run start'
alias composer="php /usr/local/bin/composer.phar"
alias shorten='PS1="\u:\W\$ "'
source ~/.git-completion.bash

export PATH=${PATH}:/usr/local/mysql/bin/
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
