#!/bin/bash
ts=$(date +"%s")
cd $HOME
git clone git@github.com:abraxas678/start.git
cd start
gpg --decrypt rclone_secure_setup2gd.sh.asc > rclonesetup.sh
sudo chmod +x *.sh
./rclonesetup.sh
rm rclonesetup.sh
echo
echo SHH
echo
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


