export LANG=en_US.utf8

export EDITOR="vim"

export PASSWORD_STORE_DIR="$HOME/workspaces/pass"

export GEM_HOME=$HOME/workspaces/ruby/gems
export GEM_PATH=$HOME/workspaces/ruby/gems

export PATH="$PATH:$HOME/workspaces/tools/bin"
export PATH="$PATH:$HOME/workspaces/ruby/gems/bin"

# Workaround for a bug in libreoffice: needed to show menu icons correctly.
export SAL_USE_VCLPLUGIN=gen

setleds -D +num

source ~/.bashrc

# Automatically start the x server when in tty1
if [[ "$(tty)" = "/dev/tty1" ]]; then
   pgrep Xorg || startx
fi

