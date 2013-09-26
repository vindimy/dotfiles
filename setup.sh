#!/bin/bash

for i in bash.bashrc screenrc vimrc
do
	sudo ln -sf `pwd`/$i /etc/$i
done

mkdir -p ~/.config/htop
sudo ln -sf `pwd`/htoprc ~/.config/htop/htoprc
