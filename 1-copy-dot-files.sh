BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


ln -s -f ${BASEDIR}/dotfiles/.git.scmbrc ~/.git.scmbrc
ln -s -f ${BASEDIR}/dotfiles/.profile ~/.profile
ln -s -f ${BASEDIR}/dotfiles/.scmbrc ~/.scmbrc
ln -s -f ${BASEDIR}/dotfiles/.zshrc ~/.zshrc
ln -s -f ${BASEDIR}/dotfiles/.env ~/.env
ln -s -f ${BASEDIR}/dotfiles/.vscode ~/
ln -s -f ${BASEDIR}/dotfiles/.git-templates ~/
ln -s -f ${BASEDIR}/dotfiles/.i3 ~/
ln -s -f ${BASEDIR}/dotfiles/.config ~/
