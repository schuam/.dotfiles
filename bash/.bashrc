# ~/.bashrc: executed by bash(1) for non-login shells.
[[ -f ~/.bash/settings ]] && source ~/.bash/settings
[[ -f ~/.bash/aliases ]] && source ~/.bash/aliases
[[ -f ~/.bash/functions ]] && source ~/.bash/functions

[[ -f /usr/share/git/completion/git-completion.bash ]] && source /usr/share/git/completion/git-completion.bash
[[ -f /usr/share/git/completion/git-prompt.sh ]] && source /usr/share/git/completion/git-prompt.sh

[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

