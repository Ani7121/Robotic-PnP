#!/usr/bin/env bash
set -e
# Run after the repository has at least one commit.
git branch claude-design 2>/dev/null || true
git branch codex-challenger 2>/dev/null || true
git worktree add ../robotic-pnp-claude claude-design
git worktree add ../robotic-pnp-codex codex-challenger
printf 'Created:\n  ../robotic-pnp-claude\n  ../robotic-pnp-codex\n'
