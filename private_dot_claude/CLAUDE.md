# Global Claude Code Configuration

## EXTREMELY IMPORTANT

1. YOU ARE AN OWNER. Expressions such as "pre-existing" issue/failure/problem/flakyness/whatever are not in your vocabulary. You OWN problems and you FIX them.
2. NEVER PUSH ANY COMMIT
3. WHEN YOU COMMIT CODE USE `Signed-off-by: Alexandre Mahdhaoui <alexandre.mahdhaoui@gmail.com>`
4. WHEN YOU COMMIT: NEVER CO-AUTHOR WITH CLAUDE THIS LOOKS UNPROFESSIONAL. I'M NOT PAYING A LICENSE TO have these horrible commits.
5. WHEN YOU COMMIT: ALWAYS use "Why/How/What/How changes were verified" commit structure

## Development Workflows

When the user requests a workflow mode or when the task matches a trigger, you MUST invoke the corresponding skill using the Skill tool. The skill contains the full workflow. Follow it exactly.

| Trigger | Skill to invoke | Use case |
|---------|----------------|----------|
| "ORCHESTRATOR mode" or substantial development task | `/orchestrator` | New features, refactors, multi-file changes in one repo |
| "META_ORCHESTRATOR mode" or cross-repo task | `/meta-orchestrator` | Features spanning 2+ repos in a `go.work` workspace |
| "TEST_DRIVEN_ORCHESTRATOR mode" or fixing failing tests | `/test-driven-orchestrator` | Test-first fix cycle |

### Critical Principles (always apply when in any orchestrator mode)

These rules are non-negotiable regardless of which orchestrator skill is active:

- **Delegate, do not implement.** You coordinate agents. You do not write code yourself.
- **Never skip review cycles.** Every implementation must pass hard-ass-code-reviewer.
- **Never skip testing.** Always run `forge test-all` before declaring completion.
- **Never proceed without user approval.** Wait for explicit approval before execution phase.
- **2-cycle max per task.** If 2 review cycles do not resolve issues, escalate to user.
- **Agent reuse within groups.** Use `resume` parameter to reuse agents within a task group. Spawn fresh agents between groups.
- **Escalate immediately** if an agent is stuck, confused, or review cycles are exhausted.

## Testing with forge

Use the `forge` MCP server for all build and test operations.

**Build commands:**

- `forge build` - Build all artifacts
- `forge build <target>` - Build a specific target (one target per call)
- `forge list build` - List available build targets

**Test commands:**

- `forge test-all` - Build all artifacts and run all test stages (use for final validation)
- `forge test run <stage>` - Run a specific test stage (one stage per call)
- `forge list test` - List available test stages

**During implementation/review:** Run targeted test stages (e.g., `unit`, `lint`) to iterate quickly. Save `forge test-all` for final validation to avoid 10+ minute waits.

**Critical requirements:**

- ALWAYS run `forge test-all` before marking any task complete
- Running `go build` alone is NOT testing
- Own all failures - "pre-existing failure" is not acceptable
- Never skip tests - fix them or implement availability checks that fail (not skip) when dependencies are unavailable
- Never run tests or commands in the background

## How do I structure commits?

Each commit uses an emoji prefix and a structured body.

**Emoji conventions:**

| Emoji | Meaning |
|---|---|
| `✨` | New feature (feat:) |
| `🐛` | Bug fix (fix:) |
| `📖` | Documentation (docs:) |
| `🌱` | Misc (chore:, test:, and others) |
| `⚠` | Breaking changes -- never use without maintainer approval |

**Commit body format:**

```
✨ Short imperative summary (50 chars or less)

Why: Explain the motivation. What problem exists?

How: Describe the approach. What strategy did you choose?

What:

- pkg/foo/bar.go: description of change
- cmd/baz/main.go: description of change

How changes were verified:

- Unit tests for new logic (go test)
- forge test-all: all stages passed

Signed-off-by: Alexandre Mahdhaoui <alexandre.mahdhaoui@gmail.com>
```

Every commit requires `Signed-off-by`. Use `git commit -s` to add it automatically.

## Documentation Style Guide

### CRITICAL: Attribution-Free Writing

**NEVER mention methodology names in committed documents or commits.** The following terms MUST NOT appear in any committed file (code, docs, README, DESIGN.md, etc.):
- "Barbara Minto", "Minto", "Pyramid Principle"
- "Amazon" (when referring to writing style/format)
- "PR/FAQ", "Six-Pager", "One-Pager" (when referring to document format)
- "SCQA" (the framework name)
- "Golden Circle", "Simon Sinek"

These methodologies inform HOW we write. They are never referenced in WHAT we write. Files under `.ai/` are exempt from this rule.

### Writing Style

- **Active voice.** "Forge builds artifacts" not "Artifacts are built by Forge."
- **Data over adjectives.** "28 CLI tools" not "many tools." Quantify everything.
- **No weasel words.** Prohibited: "very", "really", "many", "some", "several", "various", "numerous", "significant", "arguably."
- **No inflated verbs.** Prohibited: "overhaul", "spearhead", "streamline", "leverage", "revamp", "architect" (as verb), "elevate", "empower", "synergize", "orchestrate" (in prose), "bolster", "foster." Use plain verbs: "update", "add", "fix", "change", "remove", "move."
- **Concise sentences.** 20 words or fewer per sentence. 30 words max.
- **No unnecessary verbosity.** Every sentence earns its place. If 30 lines suffice, write 30.
- **Define acronyms** on first use: "Model Context Protocol (MCP)."

### README.md Format

The README is customer-facing. Structure it as follows:

1. **Title + bold tagline** — one sentence stating core value proposition
2. **User quote** — developer persona describing their problem and how this solves it (2-3 sentences)
3. **"What problem does [Project] solve?"** — state the situation, the complication, the question it raises, and the answer. One short paragraph (4-6 sentences).
4. **Quick Start** — working example in <20 lines. Install, configure, run, see result.
5. **"How does it work?"** — ASCII architecture diagram + 3-4 sentence explanation. Link to DESIGN.md.
6. **Table of Contents** — question-based headers linking to remaining sections
7. **Question-based sections** — "How do I configure?", "How do I build and test?", "What tools are included?", "How do I extend?"
8. **FAQ** — 5-7 real questions users would ask, with direct answers
9. **Documentation links** — organized by audience (user, developer, design)
10. **Contributing + License**

Max 250 lines.

### DESIGN.md Format

The DESIGN.md is a technical design document. No line limit — write what is needed, but no unnecessary verbosity. Structure:

1. **Title + one-sentence design statement**
2. **Problem Statement** — situation, complication, question, answer. More technical depth than README.
3. **Tenets** — 5-6 prioritized design principles. When tenets conflict, higher-ranked wins.
4. **Requirements** — from user perspective, not implementation perspective
5. **Out of Scope** — explicit boundaries to prevent scope creep
6. **Success Criteria** — quantified, measurable outcomes
7. **Proposed Design** — high-level first:
   - ASCII architecture diagram (system-wide)
   - ASCII sequence diagrams (key workflows)
   - Explain engine resolution, testenv chain composition, lazy rebuild, parallel execution
8. **Technical Design** — drill down to lower levels:
   - Data model (key Go types, abbreviated)
   - Protocol details (MCP/JSON-RPC 2.0)
   - Component catalog (all CLI tools)
   - Package catalog (public + internal)
9. **Design Patterns** — 2-3 sentences each, no fluff
10. **Alternatives Considered** — always include "do nothing" option with rejection rationale
11. **Risks and Mitigations**
12. **Testing Strategy**
13. **FAQ** — 3-5 technical design questions
14. **Appendix** — forge.yaml example, supporting data

### CONTRIBUTING.md Format

The CONTRIBUTING.md is the contributor onboarding document. Structure it as follows:

1. **Bold tagline** — one sentence for contributors
2. **Quick start** — clone, build, test in ~10 lines
3. **"How do I structure commits?"** — emoji convention, Why/How/What/Verification body, Signed-off-by
4. **"How do I submit a pull request?"** — branch, test, PR format
5. **"How do I run tests?"** — all test stages with commands, test environment management
6. **"How is the project structured?"** — directory tree with brief explanation
7. **"What does each CLI tool do?"** — categorized tables (all tools, grouped by function)
8. **"What does each package do?"** — pkg/ table + internal/ table
9. **"How do I create a new engine?"** — forge-dev workflow, link to docs/dev/
10. **"What conventions must I follow?"** — build tags, license headers, generated files, linting

Max 250 lines.

### General Documentation Principles

- **Write from the user's perspective** — they have a problem, not curiosity about internals
- **Anticipate questions** — if someone would ask it, make it a section header
- **Show, don't describe** — code examples immediately after concepts
- **Layer depth** — quick start first, implementation details later
- **Link to specifics** — reference detailed docs rather than duplicating

### Diagrams

**All diagrams MUST be in plain text ASCII format:**

- **NO Mermaid, NO PlantUML, NO special syntax** — just raw text
- Diagrams must be readable without any rendering or tooling
- This constraint intentionally forces SIMPLE SOLUTIONS
- If a design cannot be expressed in plain ASCII, it is TOO COMPLEX — simplify

**Required diagram types based on scope:**

- **Architecture diagram**: Always required — shows system components and relationships
- **Sequence diagram**: Required for features with multi-step workflows
- **Data model diagram**: Required when data structures change
- **State diagram**: Required for stateful components

### Anti-Patterns

- Explaining internals before showing usage
- Sections titled "Overview", "Introduction", "Background"
- Answering questions nobody asked
- Burying the quick start below architecture diagrams
- Diagrams requiring special rendering tools
- Mentioning methodology names (see Attribution-Free Writing above)

## EXTREMELY IMPORTANT

YOU ARE AN OWNER. Expressions such as "pre-existing" issue/failure/problem/flakyness/whatever are not in your vocabulary. You OWN problems and you FIX them.
