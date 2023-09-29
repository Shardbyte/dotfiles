#!/bin/sh
###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
# Custom .zshrc file
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
fi


#################
#  ZSH Plugins  #
#################


##################################################
zsh_shard_theme=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/themes/shardbyte.zsh-theme
if [ ! -f "$zsh_shard_theme" ]; then
  echo "Installing zsh-shard-theme..."
  curl -fsSL -o "$zsh_shard_theme" https://raw.githubusercontent.com/Shardbyte/dotfiles/main/.oh-my-zsh/custom/themes/shardbyte.zsh-theme
fi
##################################################
zsh_zshrc="$HOME/.zshrc"
if [ ! -f "$zsh_zshrc" ]; then
  echo "Installing zsh-zshrc..."
  curl -fsSL -o "$zsh_zshrc" https://raw.githubusercontent.com/Shardbyte/dotfiles/main/.oh-my-zsh/.zshrc
fi
##################################################
zsh_completions=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions
if [ ! -d "$zsh_completions" ]; then
  echo "Installing zsh-completions..."
  git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
fi
##################################################
zsh_autosuggestions=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d "$zsh_autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
fi
##################################################
zsh_syntax_highlighting=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d "$zsh_syntax_highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
fi
##################################################


plugins=(
  git
  nmap
  sudo
  aliases
  docker
  docker-compose
  command-not-found
)


###########################
#  Environment variables  #
###########################


export TERM=xterm-256color


#############
#  Aliases  #
#############

# Depending on OS type
which_os=$(grep -o '^ID=.*$' /etc/os-release)
if [ "$which_os" = "ID=fedora" ]; then
  alias cat="bat"
  alias c="bat -n"
  alias catp="bat --plain"
  alias cdiff="bat --diff"
elif [ "$which_os" = "ID=debian" ] ; [ "$which_os" = "ID=ubuntu" ]; then
  alias cat="batcat"
  alias c="batcat -n"
  alias catp="batcat --plain"
  alias cdiff="batcat --diff"
else
  echo "No Changes" > /dev/null
fi

#alias for sudo. it allows using sudo with aliases
alias sudo="sudo "
alias s="sudo "

alias locip="ip -4 a show | grep ens | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
alias pubip="curl -s http://ipecho.net/plain; echo"
alias mkdir="mkdir -p"

# ensures that these commands ask confirmation first
# -i interactive (prompt) -v verbose (explain what is being done)
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"

#Navigate up the directory using only dots
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."


############
#  Prompt  #
############


# Permission when creating files
umask 0077

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
# Ask if you have over 10000 history
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
fi


if [ "$SHELL" != "/usr/bin/zsh" ]; then
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


############
#  Source  #
############


# "Launch" Oh-My-Zsh
source $ZSH/oh-my-zsh.sh
# "Launch" ZSH-autoSuggestions
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# "Launch" ZSH-syntaxHighlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
