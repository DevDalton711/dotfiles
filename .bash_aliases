# Quick checkpoint commit before running an agent task
savepoint() {
  local msg="${1:-checkpoint before ai edit}"
  git add -A && git commit -m "checkpoint: $msg"
}

# Instant rollback to the last checkpoint, discarding AI changes
undo-ai() {
  git reset --hard HEAD
  git clean -fd
}
