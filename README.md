# .dotfiles

A centralized configuration repository for a consistent, keyboard-centric development environment. Managed via GNU Stow and shell scripts to ensure reproducibility across machines.

## Features

* **Neovim:** Custom configuration focusing on performance and extensibility.
    * **LSP:** Native LSP client with auto-completion and diagnostics.
    * **Treesitter:** Advanced syntax highlighting and code parsing.
    * **Telescope:** Fuzzy finding for files, buffers, and grep.
* **Shell (Zsh):** Optimized Zsh setup with custom prompts and aliases.
* **Multiplexer:** Tmux configuration for session management.
* **Automation:** Custom scripts for backups (`backup-scripts`) and system maintenance (`scripts`).
* **Containerization:** Dedicated Docker configurations (`.docker`) for reproducible dev environments.
* **Security:** SSH configuration management (`.ssh`).
* **Aesthetics:** Consistent theming across tools (`.themes`).

## Structure

The repository follows a Unix-like directory structure designed for easy symlinking:

* `.config/` - Core configurations (Neovim, Alacritty/Kitty, etc).
* `.docker/` - Global Docker definitions.
* `.ssh/` - SSH config management.
* `.themes/` - UI themes and color schemes.
* `backup-scripts/` - Utilities for data backup and recovery.
* `scripts/` - General purpose automation scripts.
* `private/` - (Gitignored) Personal preferences and secrets.

## Installation

### Prerequisites

* **Git**
* **GNU Stow** (recommended for symlinking)
* **Zsh**

### Setup

Clone the repository to your home directory:

```bash
git clone [https://github.com/arthurgehrke/.dotfiles.git](https://github.com/arthurgehrke/.dotfiles.git) ~/.dotfiles
cd ~/.dotfiles
