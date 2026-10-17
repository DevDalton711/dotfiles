#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create global config directories
mkdir -p ~/.agents ~/.claude ~/.gemini

# Symlink your dotfiles skills directory to the agent locations
ln -sfn "$DOTFILES_DIR/skills" ~/.agents/skills
ln -sfn "$DOTFILES_DIR/skills" ~/.claude/skills
ln -sfn "$DOTFILES_DIR/skills" ~/.gemini/skills
