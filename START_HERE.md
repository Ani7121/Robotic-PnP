# Start Here

## 1. Fill in the project state
Edit `PROJECT_STATE.md` with the current project objective, constraints, hardware, budget, timeline, known facts, and open questions.

## 2. Read the engineering constitution
`ENGINEERING_CONSTITUTION.md` defines what both AI teams are allowed to assume, how evidence is handled, and who has decision authority.

## 3. Create one real engineering task
Copy `templates/TASK_TEMPLATE.md` into `docs/tasks/TASK-001-<name>.md`.

Good first-task characteristics:
- one meaningful design decision,
- cross-disciplinary enough to benefit from multiple agents,
- small enough to test physically within days rather than months.

## 4. Run the Claude Design Team
Claude agent teams are enabled for this project through `.claude/settings.json`.

From the repo root, start Claude Code and ask:

> Read CLAUDE.md, ENGINEERING_CONSTITUTION.md, PROJECT_STATE.md, and TASK-001. Create a Design Team for this task using the role briefs in .claude/agents/. Require independent first-pass analyses before teammates exchange findings. Then deliberate, preserve meaningful dissent, and produce a proposal using templates/ENGINEERING_RECOMMENDATION_TEMPLATE.md. Do not mark anything accepted.

Use ordinary subagents instead of a full agent team for small isolated research/checking tasks.

## 5. Run the Codex Engineering Team
From the repo root, start Codex and ask:

> Read AGENTS.md, ENGINEERING_CONSTITUTION.md, PROJECT_STATE.md, and the active task. Follow any requirements-only restrictions in that task. Use the relevant engineering roles from .codex/roles/ for independent assessment and recorded peer discussion. Produce the technical recommendation, then have the Technical Communicator create a separate intuitive Chief Engineer reference. Preserve and link the technical report, evidence and discussion. Do not mark decisions ACCEPTED. Claude is currently inactive; cross-review only if the Chief Engineer activates it.

## 6. Human decision
Compare both proposals. If evidence is insufficient, commission an experiment instead of forcing consensus.

If you accept a decision, copy `templates/ADR_TEMPLATE.md` to `docs/decisions/ADR-001-<name>.md` and fill it out.

## 7. Execute and test
Create an execution packet from `templates/EXECUTION_PACKET_TEMPLATE.md`, build/test the subsystem, and store measured results under `docs/experiments/`.

## Rule
`main` contains accepted project truth. Agent proposals are not accepted truth until the human Chief Engineer approves them.
