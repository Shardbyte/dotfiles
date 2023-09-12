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

ZSH_THEME="shardbyte"


#################
#  ZSH Plugins  #
#################

# Check if oh-my-zsh is installed
if [ ! -d $ZSH ]; then
  echo --------------------------
  echo   Installing Oh-My-Zsh
  echo --------------------------
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/bat/ ]; then
  echo --------------------------
  echo    Installing bat
  echo --------------------------
  git clone https://github.com/sharkdp/bat.git $ZSH/custom/plugins/bat
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/zsh-autosuggestions/ ]; then
  echo --------------------------------------
  echo    Installing zsh-autosuggestions
  echo --------------------------------------
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/custom/plugins/zsh-autosuggestions
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/eza/ ]; then
  echo --------------------------
  echo    Installing eza
  echo --------------------------
  git clone https://github.com/eza-community/eza.git $ZSH/custom/plugins/eza
fi

# Install custom plugins
if [ ! -d $ZSH/custom/plugins/ctop/ ]; then
  echo --------------------------
  echo    Installing ctop
  echo --------------------------
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
  echo ------------------------------------------
  echo    Installing zsh-syntax-highlighting
  echo ------------------------------------------
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
fi

plugins=(
  git
  docker
  docker-compose
  docker-zsh-completion
  command-not-found
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  bat
  eza
  ctop
  nmap
  sudo
  aliases
)

# "Launch" Oh-My-Zsh
source $ZSH/oh-my-zsh.sh


###########################
#  Environment variables  #
###########################

export TERM=xterm-256color


#############
#  Aliases  #
#############

alias s="sudo"

# YADM - Yet Another Dotfiles Manager
alias yst="yadm status"
alias ya="yadm add"
alias yd="yadm diff"
alias yds="yadm diff --staged"
alias yc="yadm commit"
alias yp="yadm push"


#############
#   Fixes   #
#############

# Fix for Slow zsh-autosuggestions Copy/Paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######
