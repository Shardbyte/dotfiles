#!/bin/sh
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
#
#
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Custom Theme
ZSH_THEME="shardbyte"

#################
#  ZSH Plugins  #
#################

# Check if oh-my-zsh is installed
if [ ! -d $ZSH ]; then
  echo --------------------------
  echo    Installing Oh-My-Zsh
  echo --------------------------
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# Install custom theme
if [ ! -f $ZSH/custom/themes/shardbyte.zsh-theme ]; then
  echo ----------------------
  echo    Installing theme
  echo ----------------------
  curl -o $ZSH/custom/themes/shardbyte.zsh-theme https://raw.githubusercontent.com/Shardbyte/dotfiles/2d5e9a698e0259d7ee33355adcc4cbc8ba644e5c/.oh-my-zsh/custom/themes/shardbyte.zsh-theme
fi


# Install custom plugins
if [ ! -d $ZSH/custom/plugins/bat/ ]; then
  echo --------------------
  echo    Installing bat
  echo --------------------
  git clone https://github.com/sharkdp/bat.git $ZSH/custom/plugins/bat
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/zsh-autosuggestions/ ]; then
  echo -------------------------------------
  echo    Installing zsh-autosuggestions
  echo -------------------------------------
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/eza/ ]; then
  echo --------------------
  echo    Installing eza
  echo --------------------
  git clone https://github.com/eza-community/eza.git $ZSH/custom/plugins/eza
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/ctop/ ]; then
  echo ----------------------
  echo    Installing ctop
  echo ----------------------
  git clone https://github.com/bcicen/ctop.git $ZSH/custom/plugins/ctop
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/docker-zsh-completion/ ]; then
  echo --------------------------------------
  echo    Installing docker-zsh-completion
  echo --------------------------------------
  git clone https://github.com/greymd/docker-zsh-completion.git $ZSH/custom/plugins/docker-zsh-completion
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/zsh-syntax-highlighting/ ]; then
  echo ----------------------------------------
  echo    Installing zsh-syntax-highlighting
  echo ----------------------------------------
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
fi

plugins=(
  git
  bat
  eza
  ctop
  nmap
  sudo
  aliases
  docker
  docker-compose
  docker-zsh-completion
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)


############
#  Source  #
############

# "Launch" Oh-My-Zsh
source $ZSH/oh-my-zsh.sh
# "Launch" ZSH-autoSuggestions
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# "Launch" ZSH-syntaxHighlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


###########################
#  Environment variables  #
###########################

export TERM=xterm-256color


#############
#  Aliases  #
#############

alias s="sudo"
alias localip="ip -4 a show | grep ens | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
alias pubip="curl -s http://ipecho.net/plain; echo"
alias mkdir="mkdir -p"


# Alias for 'exa' with long format and tree view
alias lx='exa -lT'
# Alias for 'exa' with human-readable file sizes and colors
alias ll='exa -lh --color=auto'
# Alias for 'exa' with details, colors, and git status
alias la='exa -lha --git'
# Alias for 'exa' with tree view and hidden files
alias lt='exa -T --all'
# Alias for 'exa' with just the basics
alias l='exa'


# Alias for 'bat' with syntax highlighting for code files
alias cat='bat'
# Alias for 'bat' with syntax highlighting and line numbers
alias c='bat -n'
# Alias for 'bat' with a plain-text output (no colors)
alias catp='bat --plain'
# Alias for 'bat' with side-by-side diff view
alias cdiff='bat --diff'


############
#  Prompt  #
############

# Permission when creating files
umask 022

# Automatic ZSH Updates // Checks every 7 days
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose default

#############
#  History  #
#############

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# ask you if you have over 10000 history
LISTMAX=10000

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # Only those that satisfy all of the following conditions are added to the history
    [[ ${#line} -ge 5
       && ${cmd} != ll
       && ${cmd} != ls
       && ${cmd} != la
       && ${cmd} != cd
       && ${cmd} != man
       && ${cmd} != scp
       && ${cmd} != ssh
       && ${cmd} != vim
       && ${cmd} != nvim
       && ${cmd} != nano
       && ${cmd} != less
       && ${cmd} != ping
       && ${cmd} != nmap
       && ${cmd} != open
       && ${cmd} != file
       && ${cmd} != which
       && ${cmd} != whois
       && ${cmd} != uname
       && ${cmd} != md5sum
       && ${cmd} != pacman
       && ${cmd} != traceroute
       && ${cmd} != speedtest-cli
    ]]
}

unsetopt extended_history
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store
# Add history
setopt append_history
# Add history incremental
setopt inc_append_history
# Share history other terminal
setopt share_history
# Duplicate command delete it older
setopt hist_ignore_all_dups
# Same command as before don't add to history
setopt hist_ignore_dups
# Commands beginning with a space delete from history list
setopt hist_ignore_space
# While calling history and executing stop editing once
unsetopt hist_verify
# Extra white space packed and recorded
setopt hist_reduce_blanks
# When writing to the history file, ignore the same as the old command.
setopt hist_save_no_dups
# Do not register the history command in the history
setopt hist_no_store
# Automatically expand history on completion
setopt hist_expand


###########
#  Fixes  #
###########

# Fix for Slow zsh-autosuggestions Copy/Paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'


# Revert from default .zshrc
if [ -f "$HOME/.zshrc.pre-oh-my-zsh" ]; then
  echo -----------------------------------
  echo    Reverting from Default .zshrc
  echo -----------------------------------
  rm .zshrc && cp .zshrc.pre-oh-my-zsh .zshrc && rm .zshrc.pre-oh-my-zsh
fi


if [ "$SHELL" != "/usr/bin/zsh" ]; then
  echo ------------------
  echo    Change Shell
  echo ------------------
  chsh -s "$(which zsh)"
fi


################
#  Completion  #
################

autoload -Uz compinit
compinit

# Docker
zstyle ":completion:*:*:docker:*" option-stacking yes
zstyle ":completion:*:*:docker-*:*" option-stacking yes
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######