# if [ -f "$HOME/.bashrc" ]; then
# . "$HOME/.bashrc"
# fi

if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

if [ -d "$HOME/.software/lua/bin" ]; then
	PATH="$HOME/.software/lua/bin:$PATH"
fi

if [ -d "$HOME/.software/luajit/bin" ]; then
	PATH="$HOME/.software/luajit/bin:$PATH"
fi

if [ -d "$HOME/.software/nvim-linux64/bin" ]; then
	PATH="$HOME/.software/nvim-linux64/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
	PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/.nvm/versions/node/v23.1.0/bin" ]; then
	PATH="$HOME/.nvm/versions/node/v23.1.0/bin:$PATH"
fi

[[ $- != *i* ]] && return

export HOST_PS1=$' '
export EDITOR="$HOME/.software/nvim-linux64/bin/nvim"
export SUDO_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

PS1="┌┤${HOST_PS1}"$'\n└> \w \[\e[92;1m\]\[\e[0;95m\]\[\e[96m\]\[\e[0m\] '

if command -v tmux &> /dev/null && [[ ! "$TERM" =~ ^(screen|tmux)$ ]] && [ -z "$TMUX" ]; then
    tmux ls &>/dev/null && tmux a || tmux
fi
