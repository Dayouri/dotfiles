#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    # curl --fail -LSs https://install-node.now.sh/latest | sh
    # export PATH="/usr/local/bin/:$PATH"
    # Or use package manager
	current_distro=`cat /etc/*-release | grep "^ID=" | grep -E -o "[a-z]\w+"`
	close_distro=`cat /etc/*-release | grep "^ID_LIKE=" | grep -E -o "[a-z]\w+"`
	if [ "$close_distro" = "arch" ]; then
		echo "installing nodejs via pacman"
		pacman -s nodejs && echo "\nnodejs has been installed sucessfully"
	elif [ "$close_distro" = "debian" ]; then
		echo "installing nodejs via apt-get"
		apt-get install nodejs && echo "\nnodejs has been installed sucessfully"
	else
		echo "Unknown linux distribution, please install nodejs manually then run the script again"
		exit 1
	fi
fi

# Use package feature to install coc.nvim

# # for vim8
# mkdir -p ~/.vim/pack/coc/start
# cd ~/.vim/pack/coc/start
# curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
# for neovim
mkdir -p ~/.local/share/nvim/site/pack/coc/start
cd ~/.local/share/nvim/site/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-tsserver --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-project --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-prettier --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-html --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-explorer --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-eslint --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-sh --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-css --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install coc-tag --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
