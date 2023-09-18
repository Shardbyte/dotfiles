#!/bin/sh
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
#
#
#
# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Custom Theme
ZSH_THEME="shardbyte"

# Check if oh-my-zsh is installed
zsh_installed="$HOME/.oh-my-zsh/"
if [ ! -d "$zsh_installed" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh is already installed"
fi


#################
#  ZSH Plugins  #
#################


##################################################
zsh_shard_theme=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes/shardbyte.zsh-theme
if [ ! -f "$zsh_shard_theme" ]; then
  echo "Installing zsh-shard-theme..."
  git clone https://raw.githubusercontent.com/Shardbyte/dotfiles/main/.oh-my-zsh/custom/themes/shardbyte.zsh-theme "$zsh_shard_theme"
else
  echo "zsh-shard-theme is already installed"
fi
##################################################
zsh_zshrc="$HOME/.zshrc"
if [ ! -f "$zsh_zshrc" ]; then
  echo "Installing zsh-zshrc..."
  git clone https://raw.githubusercontent.com/Shardbyte/dotfiles/main/.oh-my-zsh/.zshrc "$zsh_zshrc"
else
  echo "zsh-zshrc is already installed"
fi
##################################################
zsh_completions=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions
if [ ! -d "$zsh_completions" ]; then
  echo "Installing zsh-completions..."
  git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
else
  echo "zsh-completions is already installed"
fi
##################################################
zsh_autosuggestions=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d "$zsh_autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
else
  echo "zsh-autosuggestions is already installed"
fi
##################################################
zsh_syntax_highlighting=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$zsh_syntax_highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
else
  echo "zsh-syntax-highlighting is already installed"
fi
##################################################
zsh_docker_ctop=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ctop
if [ ! -d "$zsh_docker_ctop" ]; then
  echo "Installing zsh-docker-ctop..."
  git clone https://github.com/bcicen/ctop "$zsh_docker_ctop"
else
  echo "zsh-docker-ctop is already installed"
fi
##################################################
zsh_batcat=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/bat
if [ ! -d "$zsh_batcat" ]; then
  echo "Installing zsh-batcat..."
  git clone https://github.com/sharkdp/bat "$zsh_batcat"
else
  echo "zsh-batcat is already installed"
fi
##################################################
zsh_eza=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/eza
if [ ! -d "$zsh_eza" ]; then
  echo "Installing zsh-eza..."
  git clone https://github.com/eza-community/eza "$zsh_eza"
else
  echo "zsh-eza is already installed"
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


###########
#  Fixes  #
###########


# Fix for Slow zsh-autosuggestions Copy/Paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'


# Revert from default .zshrc
if [ -f "$HOME/.zshrc.pre-oh-my-zsh" ]; then
  rm .zshrc \
  && cp .zshrc.pre-oh-my-zsh .zshrc \
  && rm .zshrc.pre-oh-my-zsh
else
  echo "Default .zshrc does not exist"
fi


if [ "$SHELL" != "/usr/bin/zsh" ]; then
  chsh -s "$(which zsh)"
else
  echo "ZSH is already the default shell"
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