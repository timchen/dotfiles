# shell prompt
export PS1="\u@\h:\w$ "

# aliases
alias ll='ls -lG'
alias la='ls -alG'

alias acki="acki -i"

alias jsonp='underscore print --color'
alias jsonpp='underscore pretty --color'

pass_length=8
alias passgen="len=${1:-$pass_length}; head -n1 /dev/urandom | base64 | tr -d -c [:alnum:] | cut -c1-$len"
## github
alias pull="git pull origin $1"
alias commit="git commit -am $1"
alias commitm="git commit -m $1"
alias tag="git tag $1"
alias push="git push origin $1"

function vim {
      if [ -n "$1" ] ; then
        command mvim --remote-tab-silent "$@"
      elif [ -n "$( mvim --serverlist )" ] ; then
        command mvim --remote-send ":call foreground()<CR>:enew<CR>:<BS>"
      else
        command mvim
      fi
    }

# terminal colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-256color

# rbenv
eval "$(rbenv init -)"
