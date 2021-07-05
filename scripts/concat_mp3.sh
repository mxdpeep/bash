#!/bin/bash

if [ ! -e ".concat" ]; then
  find . -maxdepth 1 -type f -size 0 -delete

  for i in *
  do
    # skip if not a directory
    if [ ! -d "$i" ]; then continue; fi
    echo -en "> $i\n"

    # check if file exists
    if [ -e "$i.mp3" ]; then
      A=`du -sb "$i" | awk '{print $1}' | awk '{print int($1)}'` # folder size, integer
      B=`du -sb "$i.mp3" | awk '{print $1}' | awk '{print int($1)+10485760}'` # file size, integer + 10 MB
      if [ "$B" -gt "$A" ]; then
        echo $i 🐱
        continue
      else
        echo "Deleting $i ..."
        sleep 2
        rm -f "$i.mp3"      
      fi
    fi

    # check if already processed
    if [ -e "$i/.concat" ]; then continue; fi

    # dive into the album
    cd "$i"
    find . -maxdepth 1 -type f -size 0 -delete

    # check for subfolders
    D=0
    for x in *
    do
      if [ -d "$x" ]; then D=1; continue; fi
    done

    # run recursively
    if [ "$D" -eq "1" ]; then echo "📁 subfolders present ..."; . $0; cd ..; continue; fi

    # check for MP3s
    FILES=`ls *.mp3 2>/dev/null`
    if [ -z "$FILES" ]; then echo "💀 no MP3s in $i"; cd ..; continue; fi

    # create MP3
    echo -en "\nProcessing: $i\n\n"
    ls *.mp3 | sed -e "s/\(.*\)/file '\1'/" | ffmpeg -protocol_whitelist 'file,pipe' -f concat -safe 0 -i - -c copy "../$i.mp3"
    touch .concat
    cd ..

    # check filesizes
    if [ -e "$i.mp3" ]; then
      A=`du -sb "$i" | awk '{print $1}' | awk '{print int($1)}'` # folder size, integer
      B=`du -sb "$i.mp3" | awk '{print $1}' | awk '{print int($1)+10485760}'` # file size, integer + 10 MB
      if [ "$B" -gt "$A" ]; then
        echo $i 🐱
        continue
      else
        echo "Deleting $i ..."
        sleep 2
        rm -f "$i.mp3"      
      fi
    fi
  done

  find . -maxdepth 1 -type f -size 0 -delete
  touch .concat
fi
