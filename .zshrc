# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.antigen.zsh

# ########################################################################
# End Powerlevel9
# ########################################################################

antigen bundle jessarcher/zsh-artisan
antigen bundle clvv/fasd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k
antigen apply

# enable vi mode
set -o vi

# enable fasd
eval "$(fasd --init auto)"

# vi mode
bindkey -v

# if OSX
if [ "$(uname)" = "Darwin" ]; then
	# add passphrase to ssh from keychain so we don't have to keep entering it
	ssh-add -A &> /dev/null
fi

# Fix SSH auth socket location so agent forwarding works with tmux
if [[ "$SSH_AUTH_SOCK" != "" && ! "$SSH_AUTH_SOCK" =~ "ssh_auth_sock" ]]; then
  ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

# if OSX
if [ "$(uname)" = "Darwin" ]; then
    # add passphrase to ssh from keychain so we don't have to keep entering it
    ssh-add -A &> /dev/null

    # export variables required by homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="$PATH:$HOME/.composer/vendor/bin"
    export PATH="$PATH:/opt/homebrew/opt/mysql-client/bin"
fi

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for settings you don’t want to commit.
for file in ~/.{exports,paths,extra,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# set fzf height and preview with bat
export FZF_DEFAULT_OPTS='--height 40% --preview "bat --style=numbers --color=always {} | head -500"'

# source local zsh config
[ -f ~/.zsh.env ] && source ~/.zsh.env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Herd injected NVM configuration
if [ -d "/Users/ike/Library/Application Support/Herd" ]; then
  export NVM_DIR="/Users/ike/Library/Application Support/Herd/config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

  [[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

  # Herd injected PHP 8.3 configuration.
  export HERD_PHP_83_INI_SCAN_DIR="/Users/ike/Library/Application Support/Herd/config/php/83/"


  # Herd injected PHP binary.
  export PATH="/Users/ike/Library/Application Support/Herd/bin/":$PATH


  # Herd injected PHP 8.2 configuration.
  export HERD_PHP_82_INI_SCAN_DIR="/Users/ike/Library/Application Support/Herd/config/php/82/"
fi
