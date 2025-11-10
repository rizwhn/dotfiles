# =============================================================================
# ZSHRC Configuration
# =============================================================================
# Author: Rizwan Iqbal (@automaticalldramatic)
# Last Updated: 2024-11-03
# Repository: github.com/automaticalldramatic/dotfiles
#
# This config is optimized for:
# - Ghostty terminal (theme-aware colors)
# - Keyboard-first workflows
# - Go development
# - GNU Stow dotfiles management
# =============================================================================

# =============================================================================
# KEY BINDINGS
# =============================================================================

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# =============================================================================
# COMPLETION SYSTEM
# =============================================================================

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable completion system
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================
# Credit: https://registerspill.thorstenball.com/p/which-command-did-you-run-1731-days

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt INC_APPEND_HISTORY        # Immediately append to history file
setopt EXTENDED_HISTORY          # Record timestamp in history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt SHARE_HISTORY             # Share history between all sessions
unsetopt HIST_VERIFY             # Execute commands using history immediately

# =============================================================================
# MODERN TOOL INTEGRATIONS
# =============================================================================

# Zsh autosuggestions
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^e' autosuggest-accept     # Ctrl+E: Accept suggestion
    bindkey '^w' autosuggest-execute    # Ctrl+W: Accept and run suggestion
fi

# FZF - Fuzzy finder
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Zoxide - Smart directory jumping
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# Atuin - Searchable shell history
if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

# Direnv - Auto-load directory environments
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# Starship - Modern prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# =============================================================================
# ALIASES - NAVIGATION
# =============================================================================

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias c='clear'
alias e='exit'

# =============================================================================
# ALIASES - FILE OPERATIONS
# =============================================================================

# Modern replacements (fallback to traditional if not installed)
if command -v eza &> /dev/null; then
    alias ls="eza"
    alias l="eza -l --icons --git -a"
    alias la="eza -la --icons --git"
    alias lt="eza --tree --level=2 --long --icons --git"
    alias ltree="eza --tree --level=2 --icons --git"
else
    # Fallback to traditional ls (without hard-coded colors for Ghostty compatibility)
    alias ls="ls -G"
    alias l="ls -lFG"
    alias la="ls -alFG"
fi

if command -v bat &> /dev/null; then
    alias cat="bat"
fi

if command -v tree &> /dev/null; then
    alias tree="tree"
fi

# =============================================================================
# ALIASES - GIT
# =============================================================================

alias gs='git status'
alias ga='git add .'
alias gc='git commit -asm'
alias gp='git push'
alias gpr='git pull --rebase'
alias gd='git diff'
alias gf='git fetch'
alias gss="git stash save"
alias gsp="git stash pop"
alias gbv="git branch -vv"
alias gcm="git checkout master; gpr"
alias gcd="git checkout develop; gpr"
alias hist="history | grep"

# Enhanced git log with topology ordering and wrapping
alias gl="git log --graph --topo-order --pretty=format:'%C(yellow)%h %C(red)%ad %C(bold blue)%an%Cgreen%d %Creset%s' --date=short"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"

# Personal git log (replace 'riz' with your git username)
alias mygl="gl --author=riz --all"

# Git flow
alias gffs="git flow feature start"
alias gffp="git flow feature publish"

# =============================================================================
# ALIASES - MISCELLANEOUS
# =============================================================================

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Utilities
alias myip="curl http://ipecho.net/plain; echo"

# IDE
alias idea="open -na \"IntelliJ IDEA.app\" --args \"$@\""

# =============================================================================
# FUNCTIONS - NAVIGATION
# =============================================================================

# cd and list
cx() { cd "$@" && ls; }

# Fuzzy cd into directory
fcd() {
    local dir
    dir=$(find . -type d -not -path '*/.*' 2>/dev/null | fzf)
    if [[ -n "$dir" ]]; then
        cd "$dir" && ls
    fi
}

# Fuzzy find file and open in nvim
fv() {
    local file
    file=$(find . -type f -not -path '*/.*' 2>/dev/null | fzf)
    if [[ -n "$file" ]]; then
        nvim "$file"
    fi
}

# Fuzzy find file and copy path to clipboard
f() {
    local file
    file=$(find . -type f -not -path '*/.*' 2>/dev/null | fzf)
    if [[ -n "$file" ]]; then
        echo "$file" | pbcopy
        echo "Copied: $file"
    fi
}

# =============================================================================
# FUNCTIONS - GIT HELPERS
# =============================================================================

# Custom git info function (if using custom prompt instead of Starship)
if ! command -v starship &> /dev/null; then
    fpath+=~/.zfuncs
    autoload -U colors && colors
    autoload -Uz git_info
    autoload -Uz ssh_info
    setopt prompt_subst
fi

# =============================================================================
# ENVIRONMENT VARIABLES - GOLANG
# =============================================================================

export CGO_ENABLED=0
export GO111MODULE=on
export GOPRIVATE=github.com/agilefoxHQ/*
export GONOPROXY=github.com/agilefoxHQ/*
export GONOSUMDB=github.com/agilefoxHQ/*

# =============================================================================
# ENVIRONMENT VARIABLES - OLLAMA
# =============================================================================

export OLLAMA_CONTEXT_LENGTH=32768
export OLLAMA_NUM_PARALLEL=4
export OLLAMA_FLASH_ATTENTION=true
export OLLAMA_HOST=http://127.0.0.1:11434
export OLLAMA_KEEP_ALIVE=10m0s
export OLLAMA_MAX_LOADED_MODELS=1

# =============================================================================
# ENVIRONMENT VARIABLES - GOOSE
# =============================================================================

export GOOSE_SHELL="/bin/zsh"
export GOOSE_INHERIT_ENV="true"

# =============================================================================
# ENVIRONMENT VARIABLES - MISCELLANEOUS
# =============================================================================

export LANG=en_US.UTF-8
export EDITOR=nvim
export GPG_TTY=$(tty)

# =============================================================================
# PATH CONFIGURATION
# =============================================================================

# Ensure Homebrew is sourced first for Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# Define common user-level bin paths. ORDER MATTERS.
USER_BIN_PATHS=(
    "$HOME/.nvm/versions/node/v22.13.1/bin"
    "$HOME/Library/pnpm"
    "$HOME/.local/bin"
    "$HOME/Code/google-cloud-sdk/bin"
    "/opt/homebrew/opt/postgresql@16/bin"
    "/usr/local/go/bin"
    "/usr/local/MacGPG2/bin"
    "/Library/Frameworks/Mono.framework/Versions/Current/Commands"
    "/Applications/iTerm.app/Contents/Resources/utilities"
    "$HOME/.lmstudio/bin"
)

# Filter out non-existent paths
CONSOLIDATED_PATH=""
for p in "${USER_BIN_PATHS[@]}"; do
    if [[ -d "$p" && ! "$CONSOLIDATED_PATH" =~ ":$p:" ]]; then
        CONSOLIDATED_PATH="$p:$CONSOLIDATED_PATH"
    fi
done

export PATH="$CONSOLIDATED_PATH:$PATH"

# =============================================================================
# TOOL INITIALIZATIONS - NODE/PYTHON
# =============================================================================

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# PNPM
export PNPM_HOME="$HOME/Library/pnpm"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# Conda
__conda_setup="$('/Users/riz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/riz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/riz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/riz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# =============================================================================
# GOOGLE CLOUD SDK
# =============================================================================

if [ -f "$HOME/Code/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/Code/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/Code/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/Code/google-cloud-sdk/completion.zsh.inc"
fi

# =============================================================================
# Z - DIRECTORY JUMPING (Legacy - Remove after migrating to zoxide)
# =============================================================================

if [ -f "$HOME/Code/z/z.sh" ]; then
    . "$HOME/Code/z/z.sh"
fi

# =============================================================================
# LOCAL OVERRIDES (Secrets, machine-specific config)
# =============================================================================

# Source local configuration file if it exists
# This file should contain:
# - API keys (GEMINI_API_KEY, ANTHROPIC_API_KEY, etc.)
# - Machine-specific paths
# - Work-specific configuration
# - Any other secrets that shouldn't be in version control

if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi

# =============================================================================
# END OF CONFIGURATION
# =============================================================================
