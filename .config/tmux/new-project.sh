#!/bin/bash

PROJECT=$(basename "$PWD")

if tmux has-session -t "$PROJECT" 2>/dev/null; then
  tmux attach-session -t "$PROJECT"
  exit 0
fi

tmux new-session -d -s "$PROJECT" -n "Editor" -c "$PWD"
tmux new-window -t "$PROJECT" -n "Builder" -c "$PWD"
tmux new-window -t "$PROJECT" -n "Terminal" -c "$PWD"

tmux send-keys -t "$PROJECT:Editor" "nvim ." Enter

if [ -f "pnpm-lock.yaml" ]; then
  tmux send-keys -t "$PROJECT:Builder" "pnpm dev" Enter
elif [ -f "package-lock.json" ]; then
  tmux send-keys -t "$PROJECT:Builder" "npm run dev" Enter
fi

tmux select-window -t "$PROJECT:Editor"
tmux attach-session -t "$PROJECT"
