#!/bin/bash
sudo ssh keygen
ts=$(date +"%s")
curl -H "Authorization: token YourGeneratedToken" --data '{"title":"test-key","key":"$(cat id_rsa.pub)"}' https://api.github.com/user/keys
eval `ssh-agent -s`
sudo chmod 400 ~/.ssh/* -R
ssh-add ~/.ssh/id_rsa
sudo chmod 700 ~/.ssh
sudo chmod 644 ~/.ssh/authorized_keys
sudo chmod 644 ~/.ssh/known_hosts
sudo chmod 644 ~/.ssh/config
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 644 ~/.ssh/id_rsa.pub
echo
sudo git clone git@github.com:abraxas678/dotfiles.git

