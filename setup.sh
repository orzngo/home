DIR=$(cd $(dirname $0); pwd)

rm -rf $DIR/../.vimrc ; ln -s $DIR/.vimrc $DIR/../.vimrc
rm -rf $DIR/../.vim ; ln -s $DIR/.vim $DIR/../.vim
rm -rf $DIR/../.zshrc ; ln -s $DIR/.zshrc $DIR/../.zshrc
rm -rf $DIR/../.bash_profile ; ln -s $DIR/.bash_profile $DIR/../.bash_profile
rm -rf $DIR/../.bashrc ; ln -s $DIR/.bashrc $DIR/../.bashrc

