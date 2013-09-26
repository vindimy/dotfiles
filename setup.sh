#!/bin/bash

for i in bashrc bash.bashrc screenrc vimrc
do
	sudo mv /etc/$i /etc/$i.old
	sudo ln -sf `pwd`/$i /etc/$i
done

mkdir -p ~/.config/htop
sudo ln -sf `pwd`/htoprc ~/.config/htop/htoprc
