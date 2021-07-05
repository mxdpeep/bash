#!/bin/bash

if [ $# -eq 0 ]; then
  echo -e "\nConvert FLAC files to MP3 recursively.\n\nSyntax: $(basename $0) <folder>\n"
  exit 1
fi
if [ -n "$1" ]; then
  if [ -d "$1" ]; then
    cd "$1"
  else
    echo -e "Invalid folder: $1\n"
    exit 1
  fi
fi

which flac >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo -e "Installing flac package...\n"
  sudo apt-get install -yqq flac
fi

which flac >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo -e "ERROR: flac is not installed!\n"
  exit 1
fi

which lame >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo -e "Installing lame package...\n"
  sudo apt-get install -yqq lame
fi

which lame >/dev/null 2>&1
if [ $? -eq 1 ]; then
  echo -e "ERROR: lame is not installed!\n"
  exit 1
fi

for i in *; do
  if [ -d "$i" ]; then
    echo "Recursing into directory: $i"
    $0 "$i"
  fi
done

for i in *.flac; do
  if [ -d "$i" ]; then
    echo "Recursing into directory: $i"
    $0 "$i"
  fi
  if [ -f "$i" ]; then
    echo "Converting: $i"
    flac -d "$i"
    lame -h --preset extreme "${i%.flac}.wav" "${i%.flac}.mp3"
  fi
done

echo -e "\nDone.\n"
