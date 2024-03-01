[[ -f ~/.zshrc ]] && . ~/.zshrc

PATH=/home/alex/.scripts:/home/alex/.local/bin:$PATH

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
