export LANG=en_US.utf8

export EDITOR="vim"

export GEM_HOME=$HOME/workspaces/ruby/gems
export GEM_PATH=$HOME/workspaces/ruby/gems

export PATH="$PATH:$HOME/workspaces/tools/bin"
export PATH="$PATH:$HOME/workspaces/ruby/gems/bin"

setleds -D +num

source ~/.bashrc

# Automatically start the x server when in tty1
#if [[ "$(tty)" = "/dev/tty1" ]]; then
#    pgrep qtile || startx
#fi
#
