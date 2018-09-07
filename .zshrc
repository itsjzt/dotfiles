export HOME="/home/abhishek"
export ZSH="$HOME/.oh-my-zsh"
export SSH_ENV="$HOME/.ssh/environment"
export TERM='xterm-256color'
export EDITOR='vim'

ZSH_THEME="agnoster"
DEFAULT_USER=`whoami`
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
}
else
    start_agent;
fi

# User specific environment and startup programs
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin"

if [[ -d $HOME/.local/bin ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi;

if [[ -d $HOME/.cargo/bin ]]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi;

if [[ -d $HOME/workspace/go ]]; then
    export GOPATH=$HOME/workspace/go
fi;

if [[ -d $HOME/.fzf/bin ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
fi;

alias ll="ls -alh"
alias virsh="virsh --connect qemu:///system"
alias python2="ipython2"
alias python="ipython3"
alias tmux="/usr/bin/tmux attach -t Base || /usr/bin/tmux new -s Base"
alias tmuxb="/usr/bin/tmux attach -t Alt || /usr/bin/tmux new -s Alt"

weather(){
    if [[ $# -eq 0 ]]; then
        curl http://wttr.in
    else
        curl "http://wttr.in/$1?m"
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
