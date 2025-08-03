#!bin/sh
# This script uses gnu stow to manage symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################
dir=~/dotfiles                    # dotfiles directory
configDirs="kitty neofetch nvim vim sketchybar zsh borders"  


echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"


for configDir in $configDirs; do
    echo "stowing $configDir"
    stow $configDir		
done
echo "done"

