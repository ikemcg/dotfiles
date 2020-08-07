source ~/.antigen.zsh

export TERM="xterm-256color"

# ########################################################################
# Start Powerlevel9
# ########################################################################
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_COLOR_SCHEME='dark'
PL9_BACKGROUND=236

# sedated
#PL9_RED=001
#PL9_GREEN=002
#PL9_YELLOW=003
#PL9_BLUE=004
#PL9_PURPLE=141

# bright
PL9_RED=196
PL9_GREEN=154
PL9_YELLOW=220
PL9_BLUE=075
PL9_PURPLE=141

# Customize prompt - https://github.com/bhilburn/powerlevel9k/tree/next#customizing-prompt-segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs vcs context time)

# shorten directory to name of current directory
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

POWERLEVEL9K_ROOT_ICON="\uf09c"
#POWERLEVEL9K_USER_ICON="\ufb8a"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

POWERLEVEL9K_USER_DEFAULT_BACKGROUND=$PL9_BLUE
POWERLEVEL9K_USER_DEFAULT_FOREGROUND=$PL9_BACKGROUND

POWERLEVEL9K_CONTEXT_TEMPLATE="%m"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=$PL9_BLUE
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=$PL9_BACKGROUND

# Set 'dir' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/dir/README.md
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$PL9_GREEN
POWERLEVEL9K_DIR_HOME_FOREGROUND=$PL9_GREEN
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$PL9_GREEN
POWERLEVEL9K_DIR_ETC_FOREGROUND=$PL9_GREEN
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='clear'
POWERLEVEL9K_DIR_HOME_BACKGROUND='clear'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='clear'
POWERLEVEL9K_DIR_ETC_BACKGROUND='clear'

# Set 'vcs' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/vcs/README.md POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$PL9_BACKGROUND
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$PL9_BACKGROUND
POWERLEVEL9K_VCS_CLOBBERED_FOREGROUND=$PL9_BACKGROUND
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$PL9_BACKGROUND
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$PL9_GREEN
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$PL9_YELLOW
POWERLEVEL9K_VCS_CLOBBERED_BACKGROUND=$PL9_RED
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$PL9_GREEN

# Set 'status' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/status/README.md
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_FOREGROUND=$PL9_GREEN
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$PL9_RED
POWERLEVEL9K_STATUS_OK_BACKGROUND=$PL9_BACKGROUND
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=$PL9_BACKGROUND

# Set 'root_indicator' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/root_indicator/README.md
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=$PL9_YELLOW
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=$PL9_BACKGROUND

# Set 'background_jobs' segment colors
# https://github.com/bhilburn/powerlevel9k/blob/next/segments/background_jobs/README.md
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$PL9_BACKGROUND
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$PL9_YELLOW

# ########################################################################
# End Powerlevel9
# ########################################################################

antigen bundle clvv/fasd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme bhilburn/powerlevel9k powerlevel9k
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
