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
  if [[ $platform == 'linux-gnu' ]]; then
    ssh-add -k ~/.ssh/id_ed25519
  fi
else
  echo "ssh-key found, moving on\n"
fi

printf "generating new gpg keys\n"
gpg --default-new-key-algo rsa4096 --gen-key

gpg --list-secret-keys --keyid-format=long
printf "get armored gpg key, run:\n"
printf "gpg --armor --export <key>\n"

printf "adding missing .vim dirs\n"
mkdir -p ~/.vim/backups && mkdir -p ~/.vim/swaps

printf "all done!\n"

