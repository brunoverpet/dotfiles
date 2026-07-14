#!/bin/bash

DOTFILES="$HOME/dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "Skipping $dst (exists and is not a symlink)"
    return
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "Linked $dst → $src"
}

link ".config/nvim"     "$HOME/.config/nvim"
link ".config/ghostty"  "$HOME/.config/ghostty"
link ".config/skhd"     "$HOME/.config/skhd"
link ".config/yabai"    "$HOME/.config/yabai"
link ".config/tmux"     "$HOME/.config/tmux"
link ".config/.zshrc"   "$HOME/.zshrc"

echo "Done."
