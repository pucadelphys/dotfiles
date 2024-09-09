#[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.scripts" ]; then
    PATH="$HOME/.scripts:$PATH"
fi

if [ -d "$HOME/.local/.juliaup/bin" ]; then
    PATH="$HOME/.local/.juliaup/bin:$PATH"
fi

EXPORT TERM=xterm-256color

HOST=$(hostname)

case ${HOST} in
    keter)
        HOST_PS1=$'┌┤\n└>%F{white} %~ %B%F{green}%F{magenta}%F{cyan}%f%b ';;
    central)
        HOST_PS1=$'┌┤󰚄\n└>%F{white} %~ %B%F{green}%F{magenta}%F{cyan}%f%b ';;
    *)
        HOST_PS1='%F{white} %~ %B%F{green}%F{magenta}%F{cyan}%f%b ';;
esac

export HOST_PS1

[[ -n ${SSH_TTY} ]] && exit


export HOST_PS1
export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim
export BROWSER=brave
export TERMINAL=alacritty

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export FONTCONFIG_PATH=/etc/fonts

export MATHEMATICA_USERBASE='/home/alex/.config/mathematica'


[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1

