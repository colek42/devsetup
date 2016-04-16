BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


ln -s ${BASEDIR}/dotfiles/.git.scmbrc ~/.git.scmbrc
ln -s ${BASEDIR}/dotfiles/.profile ~/.profile
ln -s ${BASEDIR}/dotfiles/.scmbrc ~/.scmbrc
ln -s ${BASEDIR}/dotfiles/.zshrc ~/.zshrc
ln -s ${BASEDIR}/dotfiles/.env ~/.env
ln -s ${BASEDIR}/dotfiles/.vscode ~/
ln -s ${BASEDIR}/dotfiles/.git-templates ~/
ln -s ${BASEDIR}/dotfiles/.i3 ~/
ln -s ${BASEDIR}/dotfiles/.config ~/
