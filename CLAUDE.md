# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a stow-based dotfiles repository for macOS and Linux. GNU Stow manages symlinks from this repo to the home directory.

## Commands

### Installation
```bash
./install.sh              # Core setup (tools + symlinks)
./install.sh --with-dev   # Include Node.js, Ruby, Python via mise
```

### Stow Operations
```bash
stow -v -t $HOME nvim     # Symlink nvim package to ~/.config/nvim
stow -v -t $HOME zsh      # Symlink zsh package to ~/.zshrc
stow -D -t $HOME nvim     # Unlink (remove symlinks) for a package
```

### Mise (Version Manager)
```bash
mise list                 # Show installed tool versions
mise install              # Install versions from .mise.toml
mise use node@20          # Switch to specific version
```

## Architecture

Each top-level directory is a "stow package" that mirrors the home directory structure:

```
<package>/.config/app/    → ~/.config/app/
<package>/.dotfile        → ~/.dotfile
```

### Packages

| Package | Target | Purpose |
|---------|--------|---------|
| `nvim/` | `~/.config/nvim/` | Neovim config with lazy.nvim plugin manager |
| `zsh/` | `~/.zshrc`, `~/.config/starship.toml` | Shell config with Starship prompt |
| `ghostty/` | `~/.config/ghostty/` | Terminal emulator settings |
| `mise/` | `~/.mise.toml` | Development tool version management |

### Neovim Structure

```
nvim/.config/nvim/
├── init.lua              # Loads modules in order
└── lua/config/
    ├── options.lua       # Editor settings (2-space indent, relative numbers)
    ├── keymaps.lua       # Leader=Space, Ctrl+hjkl window nav, Space+w save
    └── lazy.lua          # Plugin manager bootstrap (auto-installs)
```

### Zsh Configuration

- History: 50k items, shared across sessions, deduplicated
- Completions: Case-insensitive fuzzy matching
- Plugins loaded: `zsh-autosuggestions`, `zsh-syntax-highlighting`
- Starship prompt initialized last

## Key Conventions

- **Indentation**: 2 spaces (configured in nvim and typical for config files)
- **Adding new packages**: Create `<name>/` directory mirroring home structure, then `stow <name>`
- **Backups**: `install.sh` creates timestamped backups in `~/.dotfiles-backup/` before stowing
