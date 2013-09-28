#!/bin/bash

dir=/usr/share/nano

for i in `ls $dir/|grep nanorc`; do echo "include $dir/$i" >> ~/.nanorc; done
