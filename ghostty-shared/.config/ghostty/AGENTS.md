# Ghostty Configuration Management

## Structure

The ghostty configuration is split across three directories:

- **ghostty-shared**: Main config file
- **ghostty-macos**: macOS-specific overrides (`config-macos`)
- **ghostty-linux**: Linux-specific overrides (`config-linux`)

The main config loads platform-specific files with:
```
config-file = ?config-macos
config-file = ?config-linux
```

## Stowing

To apply changes from the dotfiles to your home directory:

```bash
stow --no-folding -v -t ~ ghostty-shared ghostty-macos
```

This creates symlinks:
- `~/.config/ghostty/config` → `ghostty-shared/.config/ghostty/config`
- `~/.config/ghostty/config-macos` → `ghostty-macos/.config/ghostty/config-macos`

Changes to these files are immediately reflected in Ghostty after reload/restart.
