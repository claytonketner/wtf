#!/bin/bash

# Symlinks this to your home directory as a hidden file and then adds to your .bashrc
if [[ -h ~/.wtf ]]; then
	echo "Symlink already exists - leaving as is."
else
	echo "Creating symlink ~/.wtf"
	ln -s $PWD/wtf.sh ~/.wtf
fi

if $(fgrep -q "source ~/.wtf" ~/.bashrc); then
	echo ".bashrc already contains source line - leaving as is"
else
	echo "Adding source snippet to .bashrc"
	echo -e "if [ -f ~/.wtf ]; then\n\tsource ~/.wtf\nfi" >> ~/.bashrc
fi

echo -e "\nDone"
