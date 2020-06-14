# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ll='ls -lh'
alias l='ll -CF'
alias la='ll -a'
alias lr='ll -R'

# disk human
alias df='df -h'
alias du='du -h'

# apt
alias uu='sudo apt-get update -qq && sleep 3 && sudo apt-get dist-upgrade && sudo apt-get autoremove -qq'
alias listpackages='dpkg --get-selections | more'
alias listinstalled='listpackages | grep -v deinstall'

# git
alias gitinit='git init && git add -A && git commit -a -m "first commit" && git config branch.master.remote origin && git config branch.master.merge refs/heads/master'
alias refreshgit='a=(*); for ((i=${#a[*]}; i>1; i--)); do j=$[RANDOM%i]; tmp=${a[$j]}; a[$j]=${a[$[i-1]]}; a[$[i-1]]=$tmp; done; for i in "${a[@]}"; do cd $i; echo -e "\n\nREPOSITORY: $i\n"; git stash; git fetch; git pull; sleep 2; cd ..; done'
alias gcl='git clone'
alias gitakt='git commit -a -m "minor update"; git push origin master -f'

# misc.
alias today='egrep -h "$(date +"%m/%d|%b* %d")" /usr/share/calendar/calendar*'
alias webmirror='wget -m --html-extension --convert-links --restrict-file-names=windows -e robots=off -U "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"'
alias flushdns='sudo /etc/init.d/nscd restart'
alias flushcache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches" && free -m'
alias setterm='gconftool --type string --set /desktop/gnome/applications/terminal/exec terminator'
alias setnemo='xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search'
alias fixlocale='sudo apt-get install language-pack-en-base language-pack-en language-pack-cs language-pack-cs-base && sudo locale-gen en_US en_US.UTF-8 && sudo locale-gen cs_CZ cs_CZ.UTF-8 && sudo dpkg-reconfigure locales'
alias vdiuuid='VBoxManage internalcommands sethduuid'
alias refreshfont='sudo fc-cache -f -v'
alias myhistory='history |tr "\011" " " |tr -s " "| cut -d" " -f3 |sort |uniq -c |sort -nbr |head -n10'
alias pingoo='ping -i.5 8.8.8.8'
alias pingcf='ping -i.5 1.1.1.1'
alias cpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -20'
alias mem='free -h; echo; ps aux | sort -rn +3 | head'
alias myip='ip -br -c a'
alias dockerupdate="docker images | grep -v REPOSITORY | awk '{print \$1}' | xargs -L1 docker pull"
alias dockerdangling="docker images -f 'dangling=true' -q"
alias showbinds='findmnt | grep  "\["'

# reload bash
alias reload='. ~/.bashrc'
