# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
oldFilesDir=~/dotfiles_old             # old dotfiles backup directory
oldConfigsDir=~/config_old
files=".p10k.zsh .zshrc"    # list of files/folders to symlink in homedir
configDirs="kitty neofetch nvim sketchybar borders"  


##########

# create dotfiles_old in homedir
echo -n "Creating $oldFilesDir for backup of any existing dotfiles in ~ ..."
mkdir -p $oldFilesDir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing config files to ~/config_old directory, then create symlinks from the configDir to any files in the ~/.config directory specified in $configDirs
echo "Moving any existing config dirs from ~/.config/ to $oldConfigsDir"
for configDir in $configDirs; do
    if [ -L ~/.config/$configDir ]; then
        echo "~/.config/$configDir is a symlink so won't move."
    else 
        echo "~/.config/$configDir is not a symlink so will move."
        mv ~/.config/$configDir $oldConfigsDir
        echo "Creating symlink to ~/.config/$configDir"
        ln -s $dir/$configDir ~/.config/$configDir
    fi
done

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the configDir to any files in the ~/dotfiles directory specified in $configDirs
echo "Moving any existing dotfiles from ~ to $oldFilesDir"
for file in $files; do
    mv ~/$file $oldFilesDir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

