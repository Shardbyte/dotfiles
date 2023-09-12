###########################
#                         #
#  Saint @ Shardbyte.com  #
#                         #
###########################
######  BEGIN FILE  ###### ######  BEGIN FILE  ###### ######  BEGIN FILE  ######
# ~/.oh.my.zsh/themes/shardbyte.zsh-theme
# Shardbyte ZSH Theme
#
#
local return_code="%(?..%{$fg[magenta]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.».➤)'
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}
╰─%B${user_symbol}%b "

################################################################################################################################
#Check if an IP address is in a private IPv4 range
is_private_ip() {
  local ip="$1"
  # Define private IP address ranges
  local private_ranges=("10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16" "169.254.0.0/16" "127.0.0.0/8")
  
  for range in "${private_ranges[@]}"; do
    if ipcalc -n -4 -c "$ip" "$range" &>/dev/null; then
      return 0 # IP is in a private range
    fi
  done
  
  return 1 # IP is not in a private range
}
################################################################################################################################
# Check if the user is connecting locally or remotely via SSH
is_local_connection() {
  if [[ "$SSH_CONNECTION" = "$1" ]]; then
    remote_ip=$(echo "$SSH_CONNECTION" | awk '{print $1}')
      RPROMPT="%W %t UTC  ⛛  $(ip a | grep ens | grep inet | tr -s ' ' | cut -d ' ' -f 3 | cut -d '/' -f 1) %{$reset_color%}"
  else
      RPROMPT="%W %t UTC  ⛛  $(curl -s http://ipecho.net/plain; echo) %{$reset_color%}"
  fi
}
################################################################################################################################

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# Ruby prompt settings
ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[grey]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

# HG prompt settings
ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

# VirtialENV prompt settings
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
#
#
######  END FILE  ###### ######  END FILE  ###### ######  END FILE  ######