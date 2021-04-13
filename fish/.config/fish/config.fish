#!/bin/bash
export EDITOR="nvim" || export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
source $HOME/.config/fish/shortcuts.fish
source $HOME/.config/fish/colors.fish
set -gx PATH $HOME/.local/bin /usr/local/bin /opt/metasploit-framework /opt/dirble /opt/exploitdb /opt/nikto/program /home/north/.cargo/bin $PATH

### flatpak ###
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

### Set "bat" as manpager
export MANPAGER=$HOME/.local/bin/batpager

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# bat
alias cat='bat'

# vim
alias v=$EDITOR
alias vi='vim'

# find to fd
alias find='fd -H'

# pacman and yay
#alias pacsyu='sudo pacman -Syyu'
#alias yaysua='yay -Sua --noconfirm'
#alias yaysyu='yay -Syu --noconfirm'
#alias parsua='paru -Sua --noconfirm'
#alias parsyu='paru -Syu --noconfirm'
#alias unlock='sudo rm /var/lib/pacman/db.lck'
#alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
#alias pacman='paru'

# get fastest mirrors
#alias mirror="sudo reflector -f 30 -l 30 -c Bulgaria --number 10 --verbose --save /etc/pacman.d/mirrorlist"
#alias mirrord="sudo reflector --latest 50 -c Bulgaria --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
#alias mirrors="sudo reflector --latest 50 -c Bulgaria --number 20 --sort score --save /etc/pacman.d/mirrorlist"
#alias mirrora="sudo reflector --latest 50 -c Bulgaria --number 20 --sort age --save /etc/pacman.d/mirrorlist"


# ls to exa
alias ls='exa  --color=always --group-directories-first'
alias la='exa -la --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

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

# top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# top process eating cpu
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# termbin
alias tb="nc termbin.com 9999"

# ip address
alias ipp='curl ipinfo.io/ip'

# doas
alias sudo='doas'
alias doas="doas --"
alias doas='doas '

# youtube-dl
alias yt="youtube-dl --add-metadata -i"
alias playlist='youtube-dl -o '\''%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\'' '
alias playlist3='youtube-dl -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '\''%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'\'' '
alias ytv='yt -f bestvideo'
alias yta='yt -x -f bestaudio/best'
alias tiktok-dl='yt --cookies "cookies_files" --referer "https://www.tiktok.com/" -o "output.mp4" '
alias ytmp3='youtube-dl -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata '

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'
