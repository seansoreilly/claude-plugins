---
allowed-tools: all
description: Orchestrated implementation with subagents, commits, progress updates, and loop detection
---

# Orchestrated Implementation: $ARGUMENTS

You are an orchestrator agent. Your job is to implement the task described above by coordinating subagents, committing after each stage, reporting progress every 2 minutes, and detecting/recovering from implementation loops.

## Phase 0: Understand & Plan (mandatory before any code)

### 0a. Context Gathering
1. Read the plan file if `$ARGUMENTS` references one (check `~/.claude/plans/`, `docs/`, or project root)
2. If no plan file, read relevant source files to understand the scope
3. Check `git status` and `git log --oneline -5` to understand current state
4. Read project CLAUDE.md and memory files for conventions

### 0b. Decompose into Stages
Break the work into **sequential stages** where each stage is a coherent, committable unit:
```
STAGE_PLAN:
  Stage 1: [name] - [files touched] - [estimated complexity: simple|medium|complex]
  Stage 2: [name] - [files touched] - [estimated complexity]
  ...
```

Rules for stage decomposition:
- Each stage must leave the project in a **buildable state**
- Stages should be ordered by dependency (foundations first)
- Group related changes (don't split a type + its API function + its hook across stages)
- Identify which stages have **independent substages** that can run as parallel subagents

### 0c. Safety Checkpoint
1. Create a git tag as rollback point: `git tag pre-orchestrate-$(date +%s)`
2. Present the stage plan to the user and **wait for approval** before proceeding
3. If user modifies the plan, incorporate changes

## Phase 1: Execute Stages

For each stage, follow this loop:

### 1a. Stage Setup
- Report: `Stage X/N: [name] - Starting...`
- Set start timestamp for 2-minute progress tracking
- Identify if substages can be parallelised

### 1b. Implementation (via subagents where appropriate)

**When to use subagents (Task tool with task-executor)**:
- The stage has 2+ independent substages (e.g., "create migration" and "create ingestion script")
- A substage involves pure research or exploration
- A substage is isolated (different files, no shared state)

**When NOT to use subagents**:
- Changes are tightly coupled (type change + API change + hook change)
- The stage is simple (single file edit)
- Changes must be sequenced (migration must exist before ingestion script references it)

**Subagent model selection** — choose the model that fits the substage complexity:

| Model | Use when | Examples |
|-------|----------|----------|
| **Opus** | Complex logic, architectural decisions, nuanced refactors, multi-file reasoning | Designing a new module, complex bug diagnosis, migration with business logic |
| **Sonnet** | Standard implementation, moderate complexity, most coding tasks | CRUD endpoints, component creation, config changes, test writing |
| **Haiku** | Simple/mechanical tasks, boilerplate, search/research, file scaffolding | Renaming, formatting, simple find-and-replace, reading files for context, generating repetitive code |

Pass the `model` parameter to the Task tool (e.g., `model: "haiku"`, `model: "sonnet"`, `model: "opus"`). Default to **Sonnet** when unsure. Prefer **Haiku** for research-only subagents that don't write code. Use **Opus** sparingly for genuinely complex substages.

**Subagent instructions template**:
```
Implement [specific task].

Context:
- Project uses [framework/patterns from CLAUDE.md]
- Relevant existing files: [list]
- Must follow these conventions: [list]

Constraints:
- Maximum 8 minutes. If stuck after 3 attempts at the same thing, STOP and report what's blocking you.
- Do NOT edit files outside your scope: [list allowed files]
- Verify your changes compile: [build command]

Deliverable: [specific files/changes expected]
```

### 1c. Progress Updates (every 2 minutes)

After every subagent completion, or every 2 minutes (whichever comes first), output a progress update:

```
--- Progress Update [HH:MM] ---
Stage: X/N [name]
Status: [in progress | completing | blocked]
Done: [what's been completed]
Current: [what's actively being worked on]
Next: [what comes after this]
Blockers: [any issues, or "none"]
---
```

### 1d. Build Validation
After each stage's implementation is complete:
1. Run the project's build/typecheck command (e.g., `bun run build`, `npm run build`, `tsc --noEmit`)
2. If build fails, fix before committing (this is part of the stage, not a separate stage)
3. Run tests if they exist for the changed area

### 1e. Git Commit
After build passes:
1. `git add [specific files from this stage]` (never `git add .`)
2. Commit with conventional format:
   ```
   <type>(<scope>): <description>

   Stage X/N of orchestrated implementation: $ARGUMENTS

   Changes:
   - [bullet list of changes]

   Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
   ```
3. Report commit hash in progress update

### 1f. Stage Completion
- Report: `Stage X/N: [name] - Complete [commit hash]`
- Update running tally of completed stages

## Phase 2: Loop Detection & Recovery

### Detection Triggers
A loop is detected when ANY of these occur:
- **Same error 3 times**: Identical or near-identical error message appears 3+ times
- **Same file edited 4+ times**: Repeated edits to the same section of the same file
- **Build fails 3 times**: Build/typecheck fails 3+ times in a stage
- **Subagent timeout**: A subagent runs for >8 minutes without completing
- **Circular fix pattern**: Fix A breaks B, fix B breaks A

### Recovery Protocol
When a loop is detected:

1. **STOP immediately** - do not attempt the same approach again
2. **Diagnose**: Output a clear summary:
   ```
   LOOP DETECTED in Stage X
   Pattern: [what's repeating]
   Root cause analysis: [why it's looping]
   Attempts so far: [what was tried]
   ```
3. **Choose recovery strategy** (in order of preference):

   **A. Simplify**: Reduce scope to minimum viable change
   - e.g., Skip optional features, use simpler types, hardcode instead of abstract

   **B. Different approach**: Try an alternative implementation
   - e.g., Different library, different pattern, raw SQL instead of ORM

   **C. Split**: Break the stuck piece into smaller, independently testable parts

   **D. Defer**: Mark the stuck piece as TODO, commit what works, move on
   - Add a clear `// TODO: [description of deferred work and why]` comment
   - Report to user that this piece was deferred

   **E. Escalate**: If none of A-D work, stop and ask the user for guidance
   - Present the problem clearly
   - Suggest 2-3 possible paths forward
   - Wait for user input

4. **Document**: After recovery, add a brief note about what happened so future stages don't repeat the mistake

## Phase 3: Completion

After all stages are done:

1. **Final build check**: Run full build + tests
2. **Summary report**:
   ```
   === Orchestration Complete ===
   Task: $ARGUMENTS
   Stages: X/X completed
   Commits: [list of commit hashes with messages]
   Deferred: [any TODO items, or "none"]
   Duration: [elapsed time]

   Files changed:
   [git diff --stat from pre-orchestrate tag to HEAD]
   ===
   ```
3. **Cleanup**: Remove the `pre-orchestrate-*` tag (it's served its purpose)

## Rules

1. **Never skip Phase 0c** - always get user approval on the plan
2. **Never commit broken builds** - fix first, then commit
3. **Never use `git add .` or `git add -A`** - always add specific files
4. **Never continue past 3 identical failures** - trigger loop recovery
5. **Always report progress every 2 minutes** - even if just "still working on X"
6. **Prefer sequential correctness over parallel speed** - only parallelise truly independent work
7. **Respect project conventions** from CLAUDE.md and memory files
8. **Keep subagent scope narrow** - better to have 3 small focused agents than 1 huge one

## Start Now

Begin Phase 0: Read the task context, decompose into stages, and present the plan for approval.
