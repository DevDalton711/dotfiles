#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create global config directories
mkdir -p ~/.agents ~/.claude ~/.gemini

# Symlink your dotfiles skills directory to the agent locations
ln -sfn "$DOTFILES_DIR/skills" ~/.agents/skills
ln -sfn "$DOTFILES_DIR/skills" ~/.claude/skills
ln -sfn "$DOTFILES_DIR/skills" ~/.gemini/skills

# Link Claude MCP configuration
mkdir -p "$HOME/.claude"
if [ -f "$DOTFILES_DIR/claude/mcp.json" ]; then
  ln -sf "$DOTFILES_DIR/claude/mcp.json" "$HOME/.claude/mcp.json"
  echo "Linked Claude MCP configuration to ~/.claude/mcp.json"
fi

# Link workspace-level MCP config if inside a workspace
if [ -d "/workspaces/agentic-lab" ] && [ -f "$DOTFILES_DIR/claude/mcp.json" ]; then
  ln -sf "$DOTFILES_DIR/claude/mcp.json" "/workspaces/agentic-lab/.mcp.json"
  echo "Linked .mcp.json to /workspaces/agentic-lab/.mcp.json"
fi
# Symlink .bash_aliases to home directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"

# Ensure .bashrc loads .bash_aliases
if ! grep -q "source ~/.bash_aliases" "$HOME/.bashrc" 2>/dev/null; then
  echo -e "\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi" >> "$HOME/.bashrc"
fi
