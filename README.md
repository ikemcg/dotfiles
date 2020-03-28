# ikemcg's dotfiles

Dotfiles for zsh, vim, git, tmux and more

## Installation

Install the dotfiles by cloning the repo to a directory in your home dir, and running the repo's `create_links`
script.  The script creates symlinks in your home directory for each dotfile in the repository.  This approach feels
cleaner to me than placing the repo at the level of the home dir and excluding everything but the dotfiles.

Be aware that the symlinks created by `create_links` will clobber existing dotfiles.

```bash
git clone https://github.com/ikemcg/dotfiles.git
dotfiles/create_links
```

## VIM Requirements

### Vundle

The vim config requires the Vundle (Vim bundle) plugin manager, which can be installed with the following:

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Once installed, run `:PluginInstall` from within vim to install the plugins

### Eslint

The ALE (Asynchronous Lint Engine) plugin uses eslint for JavaScript linting.  I add eslint as a development
dependency on my projects, but I also like to install it sytem-wide with the following:

```
npm install -g eslint
```

### PHP CodeSniffer

ALE uses PHP CodeSniffer for PHP linting.  Install it system-wide with the following:

```
composer global require "squizlabs/php_codesniffer=*"
```

## ZSH Requirements

#### Antigen

```
brew install antigen
```

#### Powerlevel9k - zsh theme

```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

#### Install Source Code Pro font patched with glyphs from nerd fonts

```
brew tap homebrew/cask-fonts
brew cask install font-sourcecodepro-nerd-font
```

#### Install Fuzzy Finder

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
