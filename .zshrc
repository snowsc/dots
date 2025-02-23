autoload -Uz compinit promptinit
compinit
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

export RESTIC_REPOSITORY=/home/snowsc/tmp/restic/snowback
export RESTIC_PASSWORD=snow

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt inc_append_history
setopt share_history

setopt autocd extendedglob nomatch notify
unsetopt beep
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/snowsc/.zshrc'

set -o vi

. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

autoload -Uz compinit
compinit
# End of lines added by compinstall

# export MOZ_ENABLE_WAYLAND=1 firefox

alias ww='curl wttr.in'
# alias r='ranger'
alias c='cal -yw'
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
# alias ps="pacman -Qi | awk '/^Name/{name=$3}/^Installed Size/{size=$4 $5; print size, name}' | sort -hr | head -n 20"
# alias st='systool -vm iwlwifi'
alias cg='systemd-cgtop'
alias ctl="find \$(echo '\$PATH' | tr ':' ' ') -type f -executable -name '*ctl'"

# Repo for dotfiles
# git init --bare $HOME/.dotfiles
# dotfiles config --local status.showUntrackedFiles no
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'


zstyle ':completion:*' rehash true

open() {
    xdg-open "$(find -type f | fzf)"
}

eval "$(zoxide init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export PATH="$PATH:$HOME/.cargo/bin"
