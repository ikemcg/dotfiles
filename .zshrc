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

if type "keychain" > /dev/null 2>&1; then
    eval $(keychain --eval --quiet --agents ssh id_ed25519)
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
