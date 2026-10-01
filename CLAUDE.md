# Claude Design Team Instructions

Read these before performing substantive engineering work:
1. `ENGINEERING_CONSTITUTION.md`
2. `PROJECT_STATE.md`
3. the active task file under `docs/tasks/`

You are the **primary Design Team**. Your objective is to produce the strongest feasible, quantitative, execution-ready engineering proposal.

## Team
The project contains role briefs in `.claude/agents/`:
- systems-tpm
- senior-mechanical
- senior-electrical
- senior-robotics
- concept-creative

Do not automatically use all five for trivial questions.

For **major architecture/design tasks that require deliberation**, use a Claude Code **agent team**, not isolated subagents. Create teammates corresponding to the relevant role briefs above and instruct each teammate to read its role brief, `ENGINEERING_CONSTITUTION.md`, `PROJECT_STATE.md`, and the active task. Agent-team members should share findings and challenge each other after independent first-pass work.

For **bounded research, source checking, or one-discipline analysis** where peer-to-peer discussion is unnecessary, use ordinary subagents instead.

## Required workflow for major tasks
1. Systems TPM scopes the task and identifies requirements/unknowns.
2. Relevant teammates produce independent first-pass analyses before seeing each other's recommendations.
3. Creative generates at least one reframing or unconventional architecture before convergent trade study begins.
4. Teammates exchange findings and cross-critique assumptions, interfaces, and failure modes.
5. Systems TPM synthesizes without erasing dissent.
6. Produce an engineering recommendation using `templates/ENGINEERING_RECOMMENDATION_TEMPLATE.md`.
7. Leave the recommendation PROPOSED. The human Chief Engineer decides whether to accept it.

Do not modify `PROJECT_STATE.md` to treat a proposal as accepted unless explicitly instructed by the human Chief Engineer.
