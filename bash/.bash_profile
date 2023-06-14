[[ -f ~/.bash/environment ]] && source ~/.bash/environment
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Start the ssh agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Automatically start the x server when in tty1
if [[ "$(tty)" = "/dev/tty1" ]]; then
   pgrep Xorg || startx
fi

