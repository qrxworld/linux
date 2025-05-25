#!/bin/bash
export HEY_HOSTNAME='openrouter'
export HEY_MODEL='deepseek/deepseek-chat-v3-0324:free'
export OLLAMA_MODELS="/home/shared/.ollama/models"

if [ -f "$HOME/.ENV" ]; then
  source ~/.ENV
fi

# Bash prompt
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='vim'
alias vim='nvim'
alias brave="brave --force-device-scale-factor=1.2"

# Clipboard 
if [[ "$OS" == "termux" ]]; then
  alias cb='termux-clipboard-set'
else
  alias cb='xsel -ib'
fi

# QRx
export QRX="$HOME/qrx"
export HISTORY="$QRX/history.md"
export ME="$QRX/$USER"
export CONTEXT="$ME/context"
export LINUX="$QRX/linux"

# VIBE 
export VIBE="$LINUX/vibe"
export HEY="$VIBE/hey"
export GIT="$HEY/bot/git.sh"
export sshadd="eval $(ssh-agent) & ssh-add"

# Git related
gs(){
  "git" "status" "$@"
}
export -f gs
gd(){
  "git" "diff" "$@"
}
export -f gs

# Vibe commands
vibe() {
  "$VIBE/vibe.sh" "$@"
}
export -f vibe
hey() {
  "$HEY/hey.sh" "$@"
}
export -f hey
context() {
  "$HEY/contextualize.sh" "$@"
}
export -f context
save() {
  "$GIT" "$@"
}
export -f save

# Foreground colors
export BLACK='\033[30m'
export RED='\033[31m'
export GREEN='\033[32m'
export YELLOW='\033[33m'
export BLUE='\033[34m'
export MAGENTA='\033[35m'
export CYAN='\033[36m'
export WHITE='\033[37m'

# Bright foreground colors
export BRIGHT_BLACK='\033[90m'
export BRIGHT_RED='\033[91m'
export BRIGHT_GREEN='\033[92m'
export BRIGHT_YELLOW='\033[93m'
export BRIGHT_BLUE='\033[94m'
export BRIGHT_MAGENTA='\033[95m'
export BRIGHT_CYAN='\033[96m'
export BRIGHT_WHITE='\033[97m'

# Background colors
export BG_BLACK='\033[40m'
export BG_RED='\033[41m'
export BG_GREEN='\033[42m'
export BG_YELLOW='\033[43m'
export BG_BLUE='\033[44m'
export BG_MAGENTA='\033[45m'
export BG_CYAN='\033[46m'
export BG_WHITE='\033[47m'

# Bright background colors
export BG_BRIGHT_BLACK='\033[100m'
export BG_BRIGHT_RED='\033[101m'
export BG_BRIGHT_GREEN='\033[102m'
export BG_BRIGHT_YELLOW='\033[103m'
export BG_BRIGHT_BLUE='\033[104m'
export BG_BRIGHT_MAGENTA='\033[105m'
export BG_BRIGHT_CYAN='\033[106m'
export BG_BRIGHT_WHITE='\033[107m'

# Reset color
export RESET='\033[0m'
