#!/bin/bash
#####################
#This script installs homebrew packages and runs all other scripts, setting everything up. Probably only want to do this on a new machine.
#####################
scriptsDir="~/dotfiles/scripts"

echo "Setup started"
echo "Installing packages from Brewfile"
brew bundle --file=~/dotfiles/Brewfile
echo "Running makesymlinks.sh"
sh $scriptsDir/makesymlinks.sh
echo "Running startservices.sh"
sh $scriptsDir/startservices.sh
echo "Running adjustrectangleygap.sh"
sh $scriptsDir/adjustrectangleygap.sh
echo "Setup complete"
