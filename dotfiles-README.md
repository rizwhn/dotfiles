
# Dotfiles Repository Structure

This repository uses GNU Stow to manage dotfiles.

## Directory Structure

```
~/Code/dotfiles/
├── README.md                      # This file
├── install.sh                     # Bootstrap script
├── Brewfile                       # Homebrew dependencies
├── .gitignore                     # Ignore secrets and local configs
│
├── zsh/                           # Zsh configuration
│   └── .zshrc                     # Main zsh config
│   └── .zshrc.local.template      # Template for secrets
│   └── .zfuncs/                   # Custom zsh functions (if any)
│
├── nvim/                          # Neovim configuration
│   └── .config/
│       └── nvim/
│           └── ... (LazyVim config)
│
├── ghostty/                       # Ghostty terminal config
│   └── .config/
│       └── ghostty/
│           └── config
│
├── starship/                      # Starship prompt config
│   └── .config/
│       └── starship/
│           └── starship.toml
│
├── git/                           # Git configuration
│   └── .gitconfig
│   └── .gitignore_global
│
└── lazygit/                       # Lazygit configuration
    └── .config/
        └── lazygit/
            └── config.yml
```

## How GNU Stow Works

GNU Stow creates symlinks from your dotfiles directory to your home directory.

**Example:**
```bash
~/Code/dotfiles/zsh/.zshrc  →  symlinks to  →  ~/.zshrc
```

When you edit `~/.zshrc`, you're actually editing `~/Code/dotfiles/zsh/.zshrc`, which is tracked in Git.

## Installation

### 1. Clone the Repository

```bash
cd ~/Code
git clone https://github.com/automaticalldramatic/dotfiles.git
cd dotfiles
```

### 2. Install Dependencies

```bash
# Run the install script (installs Homebrew packages and sets up dotfiles)
./install.sh
```

Or manually:

```bash
# Install Homebrew packages
brew bundle --file=Brewfile

# Install GNU Stow
brew install stow

# Stow all configurations (from ~/Code/dotfiles directory)
cd ~/Code/dotfiles
stow --no-folding -t ~ zsh
stow --no-folding -t ~ nvim
stow --no-folding -t ~ ghostty
stow --no-folding -t ~ starship
stow --no-folding -t ~ git
stow --no-folding -t ~ lazygit
```

### 3. Set Up Secrets

```bash
# Copy the template and add your secrets
cp ~/.zshrc.local.template ~/.zshrc.local
nvim ~/.zshrc.local  # Add your API keys
```

### 4. Reload Shell

```bash
source ~/.zshrc
```

## Usage

### Adding New Dotfiles

1. Create a new directory for the tool:
   ```bash
   mkdir -p ~/Code/dotfiles/tool-name
   ```

2. Move config files maintaining home directory structure:
   ```bash
   # Example: Adding .tool-config from home directory
   mv ~/.tool-config ~/Code/dotfiles/tool-name/.tool-config
   ```

3. Stow the new configuration:
   ```bash
   cd ~/Code/dotfiles
   stow --no-folding -t ~ tool-name
   ```

### Updating Dotfiles

Just edit the files in `~/Code/dotfiles/`. Since they're symlinked, changes are immediate.

```bash
nvim ~/Code/dotfiles/zsh/.zshrc
# Changes are immediately reflected in ~/.zshrc
```

### Committing Changes

```bash
cd ~/Code/dotfiles
git add .
git commit -m "Update zsh configuration"
git push
```

### Removing a Configuration

```bash
cd ~/Code/dotfiles
stow -D -t ~ zsh  # Removes symlinks
```

### Reinstalling on a New Machine

```bash
# 1. Clone the repo
git clone https://github.com/automaticalldramatic/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles

# 2. Run install script
./install.sh

# 3. Set up secrets
cp ~/.zshrc.local.template ~/.zshrc.local
nvim ~/.zshrc.local
```

## Troubleshooting

### "Conflicting files" error when stowing

If Stow reports conflicts, it means files already exist in your home directory.

**Solution:**
```bash
# Backup existing config
mv ~/.zshrc ~/.zshrc.backup

# Then stow
cd ~/Code/dotfiles
stow --no-folding -t ~ zsh
```

### Symlinks not working

Check if symlinks were created:
```bash
ls -la ~ | grep "\->"
```

You should see entries like:
```
.zshrc -> Code/dotfiles/zsh/.zshrc
```

### Changes not reflecting

Make sure you're editing the files in `~/Code/dotfiles/`, not the symlinks directly (though both work).

## Notes

- `.zshrc.local` is NOT tracked in Git (see `.gitignore`)
- Always test changes before committing
- Keep sensitive information in `.zshrc.local` only
- Use `stow -nv -t ~ PACKAGE` (dry-run) to preview changes before applying

## Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Managing Dotfiles with GNU Stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
