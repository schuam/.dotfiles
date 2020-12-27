export LANG=en_US.utf8

export EDITOR="vim"

export PATH="$PATH:$HOME/workspaces/tools/bin"
export PATH="$PATH:$HOME/workspaces/ruby/gems/bin"

# Clean Up (XDG)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/multimedia/music"
export XDG_PICTURES_DIR="$HOME/multimedia/pictures_and_videos"
export XDG_TEMPLATES_DIR="$HOME/workspaces/templates"
export XDG_VIDEOS_DIR="$HOME/multimedia/pictures_and_videos"

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export GEM_HOME=$HOME/workspaces/ruby/gems
export GEM_PATH=$HOME/workspaces/ruby/gems
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export PASSWORD_STORE_DIR="$HOME/workspaces/pass"
export LESSHISTFILE="-"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export KDEHOME="$XDG_CONFIG_HOME"/kde
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuch-config
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export VIMINIT='if !has("nvim") | let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | else | let $MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim" | endif | source $MYVIMRC'
export HISTFILE="$XDG_DATA_HOME"/bash/history

# Workaround for a bug in libreoffice: needed to show menu icons correctly.
export SAL_USE_VCLPLUGIN=gen

setleds -D +num

source ~/.bashrc

# Automatically start the x server when in tty1
if [[ "$(tty)" = "/dev/tty1" ]]; then
   pgrep Xorg || startx
fi

