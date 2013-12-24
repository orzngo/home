DIR=$(cd $(dirname $0); pwd)

rm -rf $DIR/../.vimrc ; ln -s $DIR/.vimrc $DIR/../.vimrc
rm -rf $DIR/../.zshrc ; ln -s $DIR/.zshrc $DIR/../.zshrc
echo \"fixme > $DIR/../.zshrc.include
rm -rf $DIR/../.bash_profile ; ln -s $DIR/.bash_profile $DIR/../.bash_profile
rm -rf $DIR/../.bashrc ; ln -s $DIR/.bashrc $DIR/../.bashrc
rm -rf $DIR/../.gitconfig ; ln -s $DIR/.bashrc $DIR/../.gitconfig
echo \#fixme > $DIR/../.gitconfig.include


rm -rf $DIR/../.vim
mkdir $DIR/../.vim
git clone https://github.com/Shougo/neobundle.vim $DIR/../.vim/bundle/neobundle.vim
vim -c "NeoBundleInstall | colorscheme jellybeans"
