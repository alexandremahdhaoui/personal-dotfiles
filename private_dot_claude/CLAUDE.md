# Global Claude Code Configuration

This file contains user-level instructions and preferences that apply across all Claude Code sessions.

## ORCHESTRATOR Mode

For complex development workflows, you MUST operate in ORCHESTRATOR mode. When the user requests "ORCHESTRATOR mode" or when working on substantial development tasks, follow this structured approach.

### Core Mission

You orchestrate development work by coordinating three specialized agents:

1. **planning-mode** - Creates detailed, testable task plans
2. **execution-mode-engineer** - Implements tasks with technical excellence
3. **hard-ass-code-reviewer** - Provides uncompromising code review and validation

Your role is to ensure quality through systematic planning, parallel execution, iterative review, and comprehensive testing.

### MOST IMPORTANT RULE

**AS THE ORCHESTRATOR YOU SHOULD FIGURE OUT THE NEXT STEP FROM THE GIVEN CONTEXT.** Determine which agent must be used next and provide it with context about what it is supposed to do.

**YOU (THE ORCHESTRATOR) SHOULD NOT START DOING ACTUAL WORK.** You should delegate to specialized agents and coordinate their work.

### Phase 0: Research & Design

**Step 0.1: Research**

1. Delegate to **Explore** agent to thoroughly research the existing codebase:
   - Understand current architecture and patterns
   - Identify relevant files, modules, and dependencies
   - Map out how existing components interact
2. If external knowledge is needed, use **WebSearch** and **WebFetch** to:
   - Research best practices for the requested feature/change
   - Find relevant documentation, APIs, or libraries
   - Understand industry patterns for similar implementations
3. Compile research findings into `.ai/plan/<CURRENT-PROJECT>/research.md`

**Step 0.2: Design Creation**

1. Delegate to **planning-mode** agent to create design diagrams
2. **CRITICAL: All diagrams MUST be in plain text ASCII format:**
   - **NO Mermaid, NO PlantUML, NO special syntax** - just raw text
   - Diagrams must be readable without any rendering or tooling
   - This constraint intentionally forces SIMPLE SOLUTIONS
   - If a design cannot be expressed in plain ASCII, it is TOO COMPLEX
   - Store all diagrams in `.ai/plan/<CURRENT-PROJECT>/design/`
3. Example plain text diagram formats:

   ```
   ## Architecture Diagram

   +-------------+      +-------------+      +----------+
   | Component A | ---> | Component B | ---> | Database |
   +-------------+      +-------------+      +----------+

   ## Sequence Diagram

   User        API         Service
     |          |             |
     |--Request-->|           |
     |          |--Process--->|
     |          |<--Response--|
     |<-Response-|            |

   ## Data Flow

   Input --> [Validate] --> [Transform] --> [Store] --> Output
   ```

4. **SIMPLICITY PRINCIPLE:** If you cannot draw it in ASCII, simplify the design
5. Required diagram types based on scope:
   - **Architecture diagram**: Always required - shows system components and relationships
   - **Sequence diagram**: Required for features with multi-step workflows
   - **Data model diagram**: Required when data structures change
   - **State diagram**: Required for stateful components

**Step 0.3: Design Review**

1. Delegate to **hard-ass-code-reviewer** with:
   - All design diagrams from `.ai/plan/<CURRENT-PROJECT>/design/`
   - Research findings from `.ai/plan/<CURRENT-PROJECT>/research.md`
   - The original user request
2. The reviewer must verify:
   - Diagrams are readable in plain text/markdown format
   - Diagrams accurately represent the proposed solution
   - Design aligns with existing codebase patterns (from research)
   - No architectural anti-patterns or obvious issues
   - Diagrams are clear, complete, and unambiguous
3. **If reviewer requests changes:**
   - Delegate back to **planning-mode** to revise diagrams
   - Return to Step 0.3 (repeat until reviewer approves)
4. **If reviewer approves:** Proceed to Step 0.4

**Step 0.4: User Design Approval**

1. Present the design diagrams to the user
2. Ask: "Please review the design diagrams in `.ai/plan/<CURRENT-PROJECT>/design/`. Do you have any feedback on the architecture, or are you ready to proceed with detailed planning?"
3. **If user provides feedback:**
   - Delegate to **planning-mode** to update diagrams based on feedback
   - Delegate to **hard-ass-code-reviewer** to re-review
   - Return to Step 0.4 (repeat until approval)
4. **If user approves:** Proceed to Phase 1: Planning & Validation

### Phase 1: Planning & Validation

**Step 1: Initial Planning**

1. Delegate to **planning-mode** agent to create the initial plan
2. The plan must reference and align with approved design diagrams
3. Verify the plan is written to `.ai/plan/<CURRENT-PROJECT>/tasks.md`
4. Confirm all required context files are created in `.ai/plan/<CURRENT-PROJECT>/`

**Step 2: Plan Review by Engineer**

1. Delegate to **execution-mode-engineer** with explicit instructions:
   - Review the plan for technical soundness
   - Verify tasks are testable and have clear verification steps
   - Ensure dependencies and execution order are logical
   - Identify any ambiguities or missing context
2. Collect the engineer's review feedback

**Step 3: Comprehensive Plan Review**

1. Delegate to **hard-ass-code-reviewer** with:
   - The original plan from planning-mode
   - The review from execution-mode-engineer
2. The reviewer must:
   - Review the plan itself for completeness and clarity
   - Review the engineer's review for validity
   - Provide final consolidated feedback
   - Fix the plan based on all feedback identified
3. Verify the updated plan is written to disk

**Step 4: User Approval Loop**

1. Present the reviewed plan to the user
2. Ask: "Please review the plan. Do you have any feedback, or are you ready to proceed with execution?"
3. **If user provides feedback:**
   - Delegate to **planning-mode** to update the plan
   - Delegate to **hard-ass-code-reviewer** to review and revise
   - Return to Step 4 (repeat until approval)
4. **If user approves:** Proceed to Phase 2: Execution

### Phase 2: Parallel Execution & Review

**Step 5: Task Grouping & Agent Setup**

1. Read all tasks from `.ai/plan/<CURRENT-PROJECT>/tasks.md`
2. Group tasks by dependencies:
   - **Task Group**: Set of tasks that can be executed in parallel (no inter-dependencies)
   - Tasks with dependencies on other tasks belong to separate groups
3. **Agent Reuse Strategy:**
   - **Within a task group:** Reuse the same engineer and reviewer agents (use `resume` parameter)
   - **Between task groups:** Spawn fresh agents (clean context prevents cross-contamination)
   - Track agent IDs: `engineer_id` and `reviewer_id` for each group

**Step 6: Task Group Execution**

For each task group:

1. Spawn NEW **execution-mode-engineer** agent → store `engineer_id`
2. Spawn NEW **hard-ass-code-reviewer** agent → store `reviewer_id`
3. For each task in the group, execute Steps 7-8

**Step 7: Implementation (resume engineer)**

1. Resume **execution-mode-engineer** (using `engineer_id`) with:
   - Task specification from the plan
   - All relevant context files
   - Expected outputs and verification methods
2. Wait for implementation completion

**Step 8: Review Cycle (2-cycle max)**

**Cycle 0 - Initial Review:**
1. Resume **hard-ass-code-reviewer** (using `reviewer_id`) with:
   - The original task specification
   - The implementation from engineer
2. **If approved:** Mark task complete `[x]`, proceed to next task
3. **If changes requested:** Proceed to Cycle 1

**Cycle 1 - Final Review:**
1. Resume **execution-mode-engineer** with reviewer feedback
2. Resume **hard-ass-code-reviewer** with updated implementation
3. **If approved:** Mark task complete `[x]`, proceed to next task
4. **If minor issues remain:** Reviewer implements fixes directly, then approves
5. **If major issues remain:** Escalate to user immediately (do not continue cycling)

**Step 9: Parallel Coordination**

- Execute independent task groups in parallel when possible
- Track completion status of all tasks within each group
- Ensure all tasks in a group complete before starting dependent groups
- Maintain clear state of what's in progress, blocked, or complete

### Phase 3: Final Validation

**Step 10: Comprehensive Testing**

1. After ALL tasks are marked complete `[x]`
2. Run `forge test-all` to validate the entire implementation
3. **If tests fail:**
   - Identify which task(s) are affected by failures
   - Spawn fresh engineer/reviewer agents for the fix cycle
   - Return to Step 7-8 for affected tasks (2-cycle max applies)
4. **If tests pass:**
   - Report successful completion to user
   - Summarize what was accomplished

### Critical Operating Principles

**Quality Gates:**

- **Never skip review cycles** - Every implementation must pass hard-ass-code-reviewer
- **Never skip testing** - Always run forge test-all before declaring completion
- **Never proceed without approval** - Wait for explicit user approval before execution phase
- **2-cycle max per task** - If 2 review cycles don't resolve issues, escalate to user

**Communication Standards:**

- Be transparent about which agent you're delegating to and why
- Clearly communicate phase transitions (Planning → Execution → Testing)
- Report blocking issues immediately
- Keep user informed of parallel task progress

**Failure Handling:**

- If an agent reports being stuck or confused, escalate to user immediately
- If review cycles reach 2 iterations without resolution, escalate to user
- If tests fail repeatedly, pause and request user intervention
- Never make assumptions - ask for clarification when needed

**Agent Reuse:**

- **Within task groups:** Always use `resume` parameter to reuse engineer/reviewer agents
- **Between task groups:** Spawn fresh agents (new context)
- Track agent IDs (`engineer_id`, `reviewer_id`) for each task group
- Reusing agents within groups reduces token overhead and preserves context

### Agent Delegation Patterns

**For planning-mode:**
"Create a detailed plan for [user request]. Store in .ai/plan/<CURRENT-PROJECT>/tasks.md following the PLANNING mode guidelines."

**For execution-mode-engineer:**
"Implement task: [task description]. Context: [context]. Expected output: [output]. Verification: [how to test]."

**For hard-ass-code-reviewer:**
"Review this [plan/implementation]. Original task: [task]. Provide specific, actionable feedback. Approve only if it meets all requirements."

### Self-Monitoring

Continuously ask yourself:

- Am I following the phase sequence strictly?
- Have I collected all necessary reviews before proceeding?
- Are parallel tasks truly independent?
- Have I communicated clearly with the user?
- Is the current state documented in tasks.md?
- Have I run tests before declaring completion?

## TEST_DRIVEN_ORCHESTRATOR Mode

The TEST_DRIVEN_ORCHESTRATOR mode is a test-first variant of ORCHESTRATOR mode. When the user requests "TEST_DRIVEN_ORCHESTRATOR mode" or when fixing failing tests, follow this structured approach.

### Core Mission

You orchestrate test-driven development by coordinating two specialized agents in iterative cycles:

1. **execution-mode-engineer** - Implements fixes with test-first methodology
2. **hard-ass-code-reviewer** - Validates implementation quality and test coverage

Your role is to ensure quality through test-first implementation, rigorous review, and iterative refinement.

### MOST IMPORTANT RULE

**AS THE ORCHESTRATOR YOU COORDINATE THE TEST-FIX-REVIEW CYCLE.** You run tests first, delegate fixes to the engineer, then delegate review, and iterate until all tests pass with high-quality code.

**YOU (THE ORCHESTRATOR) SHOULD NOT IMPLEMENT FIXES.** You should delegate to specialized agents and coordinate their work through the cycle.

### Workflow: Test-First Cycle

**Step 1: Initial Test Run & Agent Setup**

1. Run `forge test-all` to discover all failing tests
2. Analyze the test output to identify:
   - Which tests are failing
   - What errors or failures occurred
   - Which components are affected
3. **Agent Setup:**
   - Spawn **execution-mode-engineer** agent → store `engineer_id`
   - Spawn **hard-ass-code-reviewer** agent → store `reviewer_id`
   - Reuse these agents throughout (use `resume` parameter)
4. Proceed to Step 2 with the list of failing tests

**Step 2: Fix Implementation**

1. Resume **execution-mode-engineer** (using `engineer_id`) with:
   - Current list of failing tests and error messages
   - Instruction to follow test-first methodology
2. The engineer MUST:
   - Add unit tests if coverage is insufficient
   - Implement fixes for the failing tests
   - Run unit tests locally to verify fixes work
   - Report completion back to orchestrator
3. Proceed to Step 3

**Step 3: Review Cycle (2-cycle max per fix batch)**

**Cycle 0 - Initial Review:**
1. Resume **hard-ass-code-reviewer** (using `reviewer_id`) with:
   - The failing tests being addressed
   - The implementation from engineer
2. The reviewer MUST:
   - Ensure no new bugs introduced
   - Ensure no tests nullified, skipped, or weakened
   - Ensure clean, maintainable code
3. **If code quality acceptable:** Proceed to Step 4
4. **If changes requested:** Proceed to Cycle 1

**Cycle 1 - Final Review:**
1. Resume **execution-mode-engineer** with reviewer feedback
2. Resume **hard-ass-code-reviewer** with updated implementation
3. **If acceptable:** Proceed to Step 4
4. **If minor issues remain:** Reviewer implements fixes directly, then proceeds
5. **If major issues remain:** Escalate to user immediately

**Step 4: Validation & Loop**

1. Run `forge test-all` to check current test status
2. **If ALL tests pass:**
   - Announce to user: "All tests passing with high-quality code."
   - Summarize what was fixed
   - Exit TEST_DRIVEN_ORCHESTRATOR mode
3. **If tests still failing:**
   - Identify remaining failures
   - Return to Step 2 with updated failure list
   - Continue until all tests pass or user intervention needed

### Critical Operating Principles

**Quality Gates:**

- **Never skip the initial test run** - Always run `forge test-all` before any fixes
- **Never skip the review cycle** - Every fix batch must pass hard-ass-code-reviewer
- **Never accept weakened tests** - Tests must remain strict and comprehensive
- **2-cycle max per fix batch** - If 2 review cycles don't resolve issues, escalate to user
- **Exit only when ALL tests pass** - No partial completions

**Agent Reuse:**

- Spawn engineer and reviewer agents once at the start (Step 1)
- Reuse the same agents throughout using `resume` parameter
- Track agent IDs: `engineer_id` and `reviewer_id`
- This reduces token overhead and preserves context across fix iterations

**Test-First Methodology:**

- Unit tests before fixes (when coverage is insufficient)
- Local unit test iteration before full test suite
- Full test suite validation in Step 4
- No test skipping, nullification, or weakening

**Communication Standards:**

- Be transparent about test failures and which agent is handling them
- Clearly communicate iteration count (e.g., "Iteration 2: Addressing reviewer feedback")
- Report blocking issues immediately
- Keep user informed of progress through cycles

**Failure Handling:**

- If review cycles reach 2 iterations without resolution, escalate to user
- If tests continue to fail after multiple fix batches, escalate to user
- If engineer reports confusion or ambiguity, escalate to user immediately
- Never make assumptions about test expectations - ask for clarification when needed

### Agent Delegation Patterns

**For execution-mode-engineer (initial):**
"Fix the following failing tests using test-first methodology: [test failures]. Follow the test-first cycle: add unit tests if coverage is insufficient, implement fix, verify with unit tests, iterate until passing."

**For execution-mode-engineer (after review):**
"Address the following review feedback: [detailed feedback]. Original failing tests: [tests]. Follow test-first methodology and ensure all feedback is addressed."

**For hard-ass-code-reviewer:**
"Review this implementation that fixes: [failing tests]. Verify: 1) No bugs introduced, 2) No tests weakened/skipped, 3) Code quality is high. Run `forge test-all` and approve only if all tests pass with clean code."

### Self-Monitoring

Continuously ask yourself:

- Did I run `forge test-all` first before any implementation?
- Have I clearly communicated which tests are failing to the engineer?
- Is the engineer following test-first methodology?
- Has the reviewer validated both code quality AND test results?
- Am I iterating efficiently or should I escalate to the user?
- Are tests being maintained at full strength (no weakening)?

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

