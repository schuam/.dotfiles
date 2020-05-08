#! /bin/bash

# Todays date as part of the backup directory name
date=`date +%Y-%m-%d`

# Create backup directory
backup_dir="$PWD/dotfiles_backup_$date"
 mkdir $backup_dir


echo
echo "bash:"
for i in .bash_logout .bashrc .bash_profile
do
    mv $HOME/$i $backup_dir
    ln -svn $PWD/bash/$i $HOME/$i
done;
ln -svn $PWD/bash/.bash $HOME/.bash

echo
echo "vim:"
for i in .vim .viminfo .vimrc
do
    mv $HOME/$i $backup_dir
    ln -svn $PWD/vim/$i $HOME/$i
done;

echo
echo "konsole"
mv $HOME/.kde/share/apps/konsole $backup_dir
ln -svn $PWD/konsole/ $HOME/.local/share/konsole

echo
echo "xinit:"
for i in .Xresources .xinitrc
do
    mv $HOME/$i $backup_dir
    ln -svn $PWD/xinit/$i $HOME/$i
done;

echo
echo "xbindkeys:"
for i in .xbindkeysrc
do
    mv $HOME/$i $backup_dir
    ln -svn $PWD/xbindkeys/$i $HOME/$i
done;

echo ".config"
cd .config
for dir in `find * -maxdepth 0 -type d`
do
    echo $dir
    mv $HOME/.config/$dir $backup_dir
    ln -svn $PWD/$dir $HOME/.config/$dir
done

