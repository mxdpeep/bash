# cd
alias ..='cd ..'
alias ...='cd ../..'

# ls
alias ll='ls -lh'
alias l='ll -CF'
alias la='ll -a'
alias lr='ll -R'

# disk human
alias df='df -h'

# apt
alias listinstalled='listpackages | grep -v deinstall'
alias listpackages='dpkg --get-selections | more'
alias uu='sudo echo "Updating APT ..." && sudo apt-get update -qq && sudo apt-get dist-upgrade && sudo apt-get autoremove -qq'

# git
alias gcl='git clone'
alias gitakt='git commit -a -m "minor update";git push origin master -f'
alias gitinit='git init && git add -A && git commit -a -m "first commit" && git config branch.master.remote origin && git config branch.master.merge refs/heads/master'

# docker
alias dockerdangling="docker images -f 'dangling=true' -q"
alias dockerports='docker ps --format "{{.Ports}}"|sort'
alias dockerupdate="docker images|grep -v REPOSITORY|awk '{print \$1}'|xargs -L1 docker pull"

# misc.
alias cpu='ps -eo pcpu,pid,user,args|sort -k 1 -r|head -20'
alias flushcache='sudo sh -c "sync;echo 3 >/proc/sys/vm/drop_caches" && free -m'
alias mem='free -h;echo;ps aux|sort -rn +3|head'
alias myhistory='history|tr "\011" " "|tr -s " "|cut -d" " -f3|sort|uniq -c|sort -nbr|head -n10'
alias myip='ip -br -c a'
alias pingcf='ping -i.5 1.1.1.1'
alias pingoo='ping -i.5 8.8.8.8'
alias refreshfont='sudo fc-cache -f -v'
alias setnemo='xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search'
alias setterm='gconftool --type string --set /desktop/gnome/applications/terminal/exec terminator'
alias showbinds='findmnt|grep "\["'
alias vdiuuid='VBoxManage internalcommands sethduuid'
alias webmirror='wget -m --html-extension --convert-links --restrict-file-names=windows -e robots=off -U "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"'
alias webserver='python3 -m http.server 8080'
alias ytbdl='yt-dlp -x --audio-format mp3'
alias pocasi='curl wttr.in/brno'
alias dnes='echo "";egrep -h "$(date +"%m/%d|%b* %d")" /usr/share/calendar/calendar*;echo ""'
alias resetpipewire='systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service'
alias listextensions="find . -type f | sed -n 's/.*\.//p' | awk '!seen[$0]++'"

# reload bash
alias reload='. ~/.bashrc'
