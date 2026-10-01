# Run after the repository has at least one commit.
# Creates separate working directories so Claude and Codex do not overwrite each other's drafts.

git branch claude-design 2>$null
git branch codex-challenger 2>$null

git worktree add ../robotic-pnp-claude claude-design
git worktree add ../robotic-pnp-codex codex-challenger

Write-Host "Created:"
Write-Host "  ../robotic-pnp-claude"
Write-Host "  ../robotic-pnp-codex"
