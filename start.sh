#!/bin/bash
echo
echo SETUP GPG MANUALLY VIA OD VAULT
rclone -v > rclonecheck
if [[ $(cat rclonecheck) == *"not found"* ]]; then
  echo; echo INSTALL RCLONE
  apt install rclone -y
fi
rm rclonecheck
if [[ ! -f ~/.config/rclone/rclone.conf ]]; then
  echo; echo "SETUP GD ON RCLONE"
  rclone config
fi
echo
echo "gpg -a --export-secret-keys [key-id] >key.asc"
echo "gpg --import"
echo
echo BUTTON
read me
echo
echo UPATE AND UPGRADE
echo
sleep 2
sudo apt-get update && sudo apt-get upgrade -y
cd $HOME
echo; echo CLONE START; echo
git clone https://github.com/abraxas678/start.git
cd start
echo; echo GPG DECRYPT RCLONESETUP; echo
echo "gpg --decrypt rclone_secure_setup2gd.sh.asc > rclonesetup.sh"
echo
sleep 2
gpg --decrypt rclone_secure_setup2gd.sh.asc > rclonesetup.sh
sudo chmod +x *.sh
echo; echo RCLONESETUP; echo
echo BUTTON
read me
./rclonesetup.sh
rm rclonesetup.sh
echo
echo SHH SETUP
echo "rclone copy gd:/sec/start/id_rsa.asc . -P"
echo
rclone copy gd:/sec/start/id_rsa.asc . -P
echo
sleep 2
echo "gpg --decrypt id_rsa.asc > id_rsa"
echo
gpg --decrypt id_rsa.asc > id_rsa
rm id*.asc
sudo mkdir $HOME/.ssh
echo; echo "SHH FOLDER RIGHTS"; echo
sudo chown abraxas678:100 $HOME -R
sudo chmod 700 -R $HOME
mv id_rsa $HOME/.ssh
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
sleep 2
rclone copy gd:sec/dotfiles ./dotfiles -Pv --skip-links --fast-list
#git clone git@github.com:abraxas678/dotfiles.git
echo
echo INSTALL ZSH
echo; cd $HOME
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -L git.io/antigen > antigen.zsh
echo
echo; echo; echo "INSTALL KEEPASSXC"
echo
mykeepass="n"
echo "WANT TO INSTALL KEEPASSXC? (y/n)"
read -n 1 -t 20 mykeepass
#printf "${BLUE3}"
if [[ $mykeepass = "y" ]]; then
sudo add-apt-repository ppa:phoerious/keepassxc -y
sudo apt-get update
sudo apt-get dist-upgrade -y
#printf "${BLUE1}"
sudo apt-get install -y keepassxc
fi
echo
echo "INSTALL sudo apt-get install -y nano curl nfs-common xclip ssh-askpass jq taskwarrior android-tools-adb conky-all"
echo
sudo apt-get install -y nano curl nfs-common xclip ssh-askpass jq taskwarrior android-tools-adb conky-all
echo
echo FONTS
echo
myfonts="n"
echo "WANT TO INSTALL FONTS? (y/n)"
read -n 1 -t 20 myfonts
if [[ $myfonts = "y" ]]; then
  #https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
  curl -X POST -H "Content-Type: application/json" -d '{"myvar1":"foo","myvar2":"bar","myvar3":"foobar"}' "https://joinjoaomgcd.appspot.com/_ah/api/messaging/v1/sendPush?apikey=304c57b5ddbd4c10b03b76fa97d44559&deviceNames=razer,Chrome,ChromeRazer&text=play%20install%20this%20font&url=https%3A%2F%2Fgithub.com%2Fromkatv%2Fpowerlevel10k-media%2Fraw%2Fmaster%2FMesloLGS%2520NF%2520Regular.ttf&file=https%3A%2F%2Fgithub.com%2Fromkatv%2Fpowerlevel10k-media%2Fraw%2Fmaster%2FMesloLGS%2520NF%2520Regular.ttf&say=please%20install%20this%20font"
  sudo apt update && sudo apt install -y zsh fonts-powerline xz-utils wget  
  ###mlocate  -----> in tmu aufsetzen
  ###### https://github.com/suin/git-remind
  # sleep 1
fi


echo
brewsetup="n"
echo "START BREW SETUP?  (y/n)              --------------timeouut 20 n"
echo
read -t 20 -n 1 brewsetup
echo
if [[ $brewsetup != "n" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/abrax/.zprofile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  sudo apt-get install build-essential -y
  brew install gcc  
fi

brew install fd
brew install fzf
brew install thefuck
$(brew --prefix)/opt/fzf/install
brew install gcalcli
echo
echo AUTOREMOVE
echo
sudo apt autoremove -y

cp $HOME/start/dotfiles/.zshrc $HOME/
cp $HOME/start/dotfiles/.p10k.zsh $HOME/
cp $HOME/start/dotfiles/.taskrc $HOME/
cp $HOME/start/dotfiles/pcc $HOME/bin
mv $HOME/start/dotfiles/bin/* $HOME/bin/


echo
echo EXEC ZSH
echo
exec zsh
