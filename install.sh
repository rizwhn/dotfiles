#!/bin/bash

# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# Author: Rizwan Iqbal (@automaticalldramatic)
# Repository: github.com/automaticalldramatic/dotfiles
#
# This script:
# 1. Installs Homebrew (if not installed)
# 2. Installs all packages from Brewfile
# 3. Sets up GNU Stow symlinks
# 4. Creates .zshrc.local from template
# 5. Configures shell defaults
# =============================================================================

set -e # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
DOTFILES_DIR="$HOME/Code/dotfiles"

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

print_header() {
  echo ""
  echo -e "${BLUE}===================================================${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}===================================================${NC}"
  echo ""
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

# =============================================================================
# PRE-FLIGHT CHECKS
# =============================================================================

print_header "Dotfiles Installation"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
  print_error "This script is designed for macOS only."
  exit 1
fi

# Check if we're in the right directory
if [ ! -f "$DOTFILES_DIR/install.sh" ]; then
  print_error "Please run this script from $DOTFILES_DIR"
  exit 1
fi

# =============================================================================
# HOMEBREW INSTALLATION
# =============================================================================

print_header "Checking Homebrew Installation"

if ! command -v brew &>/dev/null; then
  print_info "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"

  print_success "Homebrew installed successfully"
else
  print_success "Homebrew is already installed"
fi

# =============================================================================
# PACKAGE INSTALLATION
# =============================================================================

print_header "Installing Packages from Brewfile"

if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  print_success "All packages installed"
else
  print_error "Brewfile not found"
  exit 1
fi

# =============================================================================
# BACKUP EXISTING CONFIGS
# =============================================================================

print_header "Backing Up Existing Configurations"

backup_file() {
  local file=$1
  if [ -f "$file" ] && [ ! -L "$file" ]; then
    mv "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
    print_success "Backed up: $file"
  fi
}

backup_file "$HOME/.zshrc"
backup_file "$HOME/.gitconfig"
backup_file "$HOME/.gitignore_global"

# =============================================================================
# GNU STOW SETUP
# =============================================================================

print_header "Setting Up Dotfiles with GNU Stow"

cd "$DOTFILES_DIR"

# Stow configurations
configs=("zsh" "git" "nvim" "ghostty" "starship" "lazygit" "atuin" "gh")

for config in "${configs[@]}"; do
  if [ -d "$config" ]; then
    print_info "Stowing $config..."
    stow --no-folding -v -t ~ "$config" 2>&1 | grep -v "LINK" || true
    print_success "$config stowed successfully"
  else
    print_warning "$config directory not found, skipping..."
  fi
done

# =============================================================================
# LOCAL CONFIG SETUP
# =============================================================================

print_header "Setting Up Local Configuration"

if [ ! -f "$HOME/.zshrc.local" ]; then
  if [ -f "$DOTFILES_DIR/zsh/.zshrc.local.template" ]; then
    cp "$DOTFILES_DIR/zsh/.zshrc.local.template" "$HOME/.zshrc.local"
    print_success "Created .zshrc.local from template"
    print_warning "Please edit ~/.zshrc.local to add your API keys and secrets"
  else
    print_warning ".zshrc.local.template not found"
  fi
else
  print_info ".zshrc.local already exists, skipping..."
fi

# =============================================================================
# SHELL CONFIGURATION
# =============================================================================

print_header "Configuring Shell"

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  print_info "Setting zsh as default shell..."
  chsh -s $(which zsh)
  print_success "Default shell set to zsh"
else
  print_success "zsh is already the default shell"
fi

# =============================================================================
# FZF SETUP
# =============================================================================

print_header "Setting Up FZF"

if command -v fzf &>/dev/null; then
  if [ ! -f "$HOME/.fzf.zsh" ]; then
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
    print_success "FZF configured"
  else
    print_info "FZF already configured"
  fi
fi

# =============================================================================
# NEOVIM SETUP
# =============================================================================

print_header "Setting Up Neovim"

if [ -d "$HOME/.config/nvim" ]; then
  print_info "Opening Neovim to install plugins..."
  print_warning "After Neovim opens, wait for LazyVim to install plugins, then run :checkhealth"
  print_warning "Press Enter to continue..."
  read
  nvim +Lazy
  print_success "Neovim setup complete"
else
  print_warning "Neovim config directory not found"
fi

# =============================================================================
# FINAL STEPS
# =============================================================================

print_header "Installation Complete!"

print_success "Dotfiles have been installed successfully"
echo ""
print_info "Next steps:"
echo "  1. Edit ~/.zshrc.local and add your API keys"
echo "  2. Run: source ~/.zshrc"
echo "  3. Verify tools are working:"
echo "     - fzf (Ctrl+R for history search)"
echo "     - zoxide (z <directory>)"
echo "     - bat (cat <file>)"
echo "     - eza (ls)"
echo "     - starship prompt should be visible"
echo "  4. Open Neovim and run :checkhealth"
echo ""
print_warning "You may need to restart your terminal for all changes to take effect"
echo ""
print_info "For troubleshooting, see: $DOTFILES_DIR/README.md"
echo ""
