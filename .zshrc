# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='%F{white} %~ %B%F{green}%F{magenta}%F{cyan}%f%b '

cl () { cd "$1" && ls --color=auto ;}
lt () { [[ -z $1 ]] && ls -lcth | head || ls -lth $1 | head ;}
mkcd () { mkdir -p "$1" && cd "$1" }
.. () { [[ $1 =~ ^[2-9]$ ]] && for i in $(seq $1); do cd .. ; done || cd .. ;}
ntfy () { curl -d "$1" ntfy.sh/Lpo5qdecKs5dxh5d >> /dev/null }
yud () { yay; [[ "${?}" -eq 0 ]] && ntfy "Upgrade Complete" || ntfy "Upgrade Failed" ;}

alias nn='TERM=xterm ncmpcpp'
alias pgrep='pgrep -l'
alias anaconda='source /opt/miniconda3/etc/profile.d/conda.sh'
alias chunkvim='nvim -u NONE -c "set nowrap"'
alias du='du -h'
alias grep='grep --color'
alias ffmpeg='noglob ffmpeg -hide_banner'
alias ll='ls -lh'
alias ls='ls --color=auto'
alias mpv='noglob mpv'
alias mv='mv -i'
alias se='sudoedit'
alias streamlink='noglob streamlink'
alias system='sudo systemctl'
alias sy='sudo pacman -Sy'
alias syu='sudo pacman -Syu'
alias tobed='sudo pacman -Syu && sudo shutdown now'
alias tsh='trash-put'
alias tree='tree -C --noreport'
alias ttop='top | head'
alias tt='trash'
alias view='nvim -R'
alias vimdiff='nvim -d'
alias vi=nvim
alias wiki='nvim -c VimwikiIndex'
alias xev='alacritty -e xev'
alias xiv='nsxiv'
alias yt-dlp='noglob yt-dlp'
alias sf='vi Downloads/torrents/stuff.txt'

[[ -z ${SSH_TTY} ]] && (cat ~/.cache/wal/newseq &)

setopt incappendhistory
setopt appendhistory
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
export KEYTIMEOUT=1

#tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^V' edit-command-line

# Backward search with ctl-r
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^R' history-incremental-search-backward

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Change prompt when vi or normal mode
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        viins|main) 
            PS1='%F{white} %~ %B%F{green}%F{magenta}%F{cyan}%f%b '
            echo -ne '\e[5 q';;
        vicmd)
            PS1='%F{white} %~ %F{green}i %F{cyan}%B%f%b '
            echo -ne '\e[1 q';;
    esac

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Fix normal mode after vi
zle -A kill-whole-line vi-kill-line
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char

# File manager function
rcd() {
    ranger --choosedir=/tmp/lastdir
    dir=$(cat /tmp/lastdir)
    cd "$dir"
}

# Customize some keys
bindkey     "^[[H"      beginning-of-line
bindkey     "^[[F"      end-of-line
bindkey     "^[[3~"     delete-char
bindkey     "^[[5~"     beginning-of-history
bindkey     "^[[6~"     end-of-history
bindkey     '^w'        backward-kill-word
bindkey     "^A"        beginning-of-line
bindkey     "^E"        end-of-line
bindkey     "^U"        backward-kill-line
bindkey     "^?"        backward-delete-char
bindkey     "^o"        kill-whole-line
bindkey     "^ "        autosuggest-accept
bindkey -a  "^[[3~"     delete-char
bindkey -a  "^?"        backward-delete-char
bindkey -a  "^["        vi-insert
bindkey -s  "^h"        "^[k0"
bindkey -s  "^d"        "^orcd\n"
#bindkey -s  "^d"        "^[dT/xa"

# Use vim keys in tab complete menu:
bindkey -M  menuselect  'h'     vi-backward-char
bindkey -M  menuselect  'k'     vi-up-line-or-history
bindkey -M  menuselect  'l'     vi-forward-char
bindkey -M  menuselect  'j'     vi-down-line-or-history
bindkey -M  menuselect  '^['    send-break

# Plugins
source ~/.config/zsh/pass.zsh-completion 2>/dev/null
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
