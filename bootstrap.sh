#!/usr/bin/env bash

platform='unknown'
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  platform='linux'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  platform='osx'
fi
printf "using platform $platform\n"


printf "adding ssh if there isn't one\n"
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "No ssh-key found, creating one\n"
  ssh-keygen -t ed25519 -C "adrianforsius@gmail.com"
  if [[ $platform == 'osx' ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
  fi
else
  echo "ssh-key found, moving on\n"
fi

printf "all done!\n"

