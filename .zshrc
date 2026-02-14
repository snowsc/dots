autoload -Uz compinit promptinit
promptinit

setopt COMPLETE_ALIASES

# This will set the default prompt to the walters theme
prompt walters

#xinput set-prop 13 319 1

export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export PAGER="/usr/bin/less"
export BROWSER=/usr/bin/firefox
export TIME_STYLE=long-iso
export XDG_DOWNLOAD_DIR="$HOME/dl"

export RESTIC_REPOSITORY=/var/backups/restic
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"
export PIP_REQUIRE_VIRTUALENV=true

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt share_history
setopt auto_param_slash

setopt autocd extendedglob nonomatch notify
unsetopt beep

zstyle :compinstall filename '/home/snowsc/.zshrc'
compinit

bindkey -v

. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

# export MOZ_ENABLE_WAYLAND=1 firefox

alias ww='curl wttr.in'
# alias r='ranger'
alias c='claude'
alias cl='cal -ywm'
#alias b='cat /sys/class/power_supply/BAT0/capacity'
alias b='acpi -b'
alias p='grep -E "installed|removed" /var/log/pacman.log'
alias pp='ps --ppid 2 --deselect f'
alias ls='ls --color=auto -F'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias j='sudo journalctl -b -e'
alias f='yazi'
alias ff='fastfetch'
alias ssa='ss -lpntu'
alias dm='sudo dmesg --follow -H --color=always'
alias wende_monitor='xrandr --output DP-1 --auto --left-of eDP-1 --output eDP-1 --off;~/.fehbg'
alias scott_monitor='xrandr --output DP-1 --mode 2560x1080 --left-of eDP-1 --output eDP-1 --off'
alias xe="grep -E '\((WW|EE)' ~/.local/share/xorg/Xorg.0.log"
alias im="pacman -Ql imagemagick | grep bin"
alias l="iw dev wlan0 link"
alias ll="iw dev wlan0 station dump"
alias d="du -sh ~/* | sort -hr"
alias t="tokei -n commas"
# alias ps="pacman -Qi | awk '/^Name/{name=$3}/^Installed Size/{size=$4 $5; print size, name}' | sort -hr | head -n 20"
# alias st='systool -vm iwlwifi'
alias cg='systemd-cgtop'

# Repo for dotfiles
# git init --bare $HOME/.dotfiles
# dotfiles config --local status.showUntrackedFiles no
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
compdef dots=git

zstyle ':completion:*' rehash true

ctl() { find ${(s.:.)PATH} -type f -executable -name '*ctl' 2>/dev/null }

open() {
    xdg-open "$(find . -type f | fzf)"
}

eval "$(zoxide init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

typeset -U path
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/.local/bin:$PATH"
