#!/bin/bash
export EDITOR="nvim" || export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
source $HOME/.config/fish/shortcuts.fish
source $HOME/.config/fish/colors.fish
set -gx PATH $HOME/.local/bin /usr/local/bin /sbin $PATH

### flatpak ###
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

### Set "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# bat
alias cat='bat'

# find to fd
alias find='fd -H'

# pacman and yay
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 -c Bulgaria --number 10 -c Bulgaria --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 -c Bulgaria --number 20 -c Bulgaria --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 -c Bulgaria --number 20 -c Bulgaria --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 -c Bulgaria --number 20 -c Bulgaria --sort age --save /etc/pacman.d/mirrorlist"

# Eza
alias ls='eza  --color=always --group-directories-first'
alias la='eza -la --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias lt='eza-aT --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'

# Colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm mv,cp,rm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'
alias free='free -m'

# ip address
alias ipp='curl ipinfo.io/ip'

# sudo
alias sudo='sudo '

# youtube-dl
alias yt="yt-dlp --add-metadata -i"
alias playlist='yt-dlp -o '\''%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\'' '
alias playlist3='yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '\''%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\'' '
alias ytv='yt -f bestvideo'
alias yta='yt -x -f bestaudio/best'
alias ytmp3='yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata '

# Starship prompt
starship init fish | source

