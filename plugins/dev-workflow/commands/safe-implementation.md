# Safe Implementation Workflow with Loop Detection and Recovery

You are implementing features using safe development practices with intelligent parallelization, loop detection, and automatic recovery mechanisms.

## PRIMARY DIRECTIVE: Complete All Task Master Tasks

**MANDATORY**: You must complete ALL tasks in the Task Master queue. Do not stop until every pending task is marked as "done" or explicitly blocked with documented reasons. This is a continuous execution workflow - keep working through the entire task list systematically.

## Enhanced Monitoring and Recovery System

### Loop Detection Criteria

A subagent is considered stuck if:
- **Time-based**: Running for more than 10 minutes on a single subtask
- **Repetition-based**: Attempting the same operation more than 3 times
- **Error-based**: Encountering the same error more than 2 times
- **File-based**: Editing the same file more than 5 times in succession
- **Build-based**: Build fails more than 3 times with similar errors

### Monitoring Protocol

1. **Active Monitoring**: When deploying task-executor agents:
   - Set explicit time limits: `"Complete this within 8 minutes or report blockers"`
   - Request progress updates: `"Report progress every 2-3 steps"`
   - Require failure reporting: `"If stuck, describe the issue and stop"`

2. **Progress Checkpoints**: Monitor for these healthy indicators:
   - Regular file reads/edits across different files
   - Successful build completions
   - Task status updates
   - Varied operations (read, edit, test, commit)

3. **Warning Signs** (potential loop):
   - Multiple identical error messages
   - Repeated edits to the same code section
   - Circular dependency resolution attempts
   - Infinite recursion in implementation
   - Repeated "file not found" for the same path

## Recovery and Fallback Strategies

### When Loop Detected

1. **Immediate Actions**:
   ```
   // STOP: Kill the stuck subagent
   "The task-executor appears stuck. Terminating and analyzing the issue..."

   // ANALYZE: Review the agent's last actions
   - What was it trying to accomplish?
   - What errors or blockers did it encounter?
   - Is there a fundamental misunderstanding?
   ```

2. **Diagnosis Phase**:
   - Check recent file modifications with `git diff`
   - Review error logs and build output
   - Identify the root cause of the loop

3. **Alternative Implementation Strategies**:

   **Strategy A: Simplification**
   - Break the task into smaller micro-tasks
   - Implement minimal viable solution first
   - Add complexity incrementally
   - Example: Instead of full feature, implement core functionality only

   **Strategy B: Different Approach**
   - Use alternative libraries or APIs
   - Try different design pattern
   - Implement workaround solution
   - Example: If ORM fails, use raw SQL; if complex state fails, use simple state

   **Strategy C: Manual Intervention**
   - Implement the specific stuck portion directly
   - Create scaffold/template for the agent to fill
   - Provide explicit step-by-step instructions
   - Example: Write the problematic function signature, let agent fill logic

   **Strategy D: Research and Learn**
   - Deploy research agent to understand the problem
   - Check documentation for the specific issue
   - Look for similar implementations in the codebase
   - Example: Find how similar features were implemented before

   **Strategy E: Defer and Continue**
   - Mark current subtask as blocked
   - Document the blocker clearly
   - Move to next independent task
   - Return to blocked task with fresh context later

## Task Master Complete Execution Strategy

### CRITICAL: Continuous Task Completion Loop

**The orchestrator MUST**:
1. Query ALL pending tasks from Task Master at start
2. Continue executing tasks until ALL are marked "done" or "blocked"
3. Never stop voluntarily - only stop when no more pending tasks exist
4. Track progress and report completion percentage regularly

### Phase 0: Task Master Integration
```
1. Get all tasks: Use mcp__task-master-ai__get_tasks or task-master list
2. Identify pending tasks and their dependencies
3. Create execution plan covering ALL pending tasks
4. Set goal: "Complete 100% of pending tasks"
5. Begin systematic execution
```

### Phase 1: Pre-Implementation Analysis
```
1. Analyze ALL Task Master tasks for dependencies and complexity
2. Group tasks by:
   - Independent (can run in parallel)
   - Sequential (have dependencies)
   - Risky (might fail or loop)
3. Plan execution order to maximize parallelization
4. Prepare fallback approaches for complex tasks
5. Calculate total task count for progress tracking
```

### Phase 2: Orchestrated Execution with Monitoring

Deploy task-orchestrator with explicit completion and monitoring instructions:

```markdown
Use task-orchestrator to coordinate COMPLETE implementation of ALL Task Master tasks:

MANDATORY INSTRUCTIONS:
- Your goal is to complete 100% of pending tasks in Task Master
- Do NOT stop until all tasks are done or explicitly blocked
- Query task list regularly to ensure nothing is missed
- Report progress as "X of Y tasks completed" every 5 tasks

Coordinate implementation with these safeguards:

1. Set time limits for each executor:
   - Simple tasks: 5 minutes
   - Medium tasks: 8 minutes
   - Complex tasks: 10 minutes

2. Monitor for loop indicators:
   - Repeated errors
   - Stuck on same file
   - No progress reports

3. If any executor appears stuck:
   - Kill the executor
   - Report the issue
   - Request alternative strategy

4. For each task, specify:
   - Maximum retry attempts: 2
   - Fallback strategy if failed
   - Dependencies that might block
```

### Phase 3: Parallel Execution with Circuit Breakers

```markdown
When deploying parallel task-executors:

1. Include circuit breaker instructions:
   "If you encounter the same error twice, stop and report"
   "If build fails 3 times, stop and await assistance"
   "If you edit the same function more than 3 times, pause"

2. Stagger deployment for observation:
   - Deploy first 2 agents
   - Monitor for 2 minutes
   - If healthy, deploy next batch
   - If issues, adjust strategy

3. Implement checkpoints:
   "After each major step, verify:
    - Build still passes
    - No regression in tests
    - No infinite loops created"
```

### Phase 4: Recovery Implementation

When a subagent gets stuck:

```markdown
1. KILL the stuck agent immediately
   - Don't wait for timeout
   - Preserve partial work if valuable

2. ANALYZE the failure:
   - What was the intended outcome?
   - Where did it get stuck?
   - What assumptions were wrong?

3. CHOOSE recovery strategy:
   a. Simplify: Reduce scope to minimum viable
   b. Alternative: Try different approach/library
   c. Manual: Implement stuck part directly
   d. Research: Understand problem better
   e. Defer: Block and move to other tasks

4. IMPLEMENT recovery:
   - Use chosen strategy
   - Set tighter constraints
   - Add more specific instructions
   - Monitor closely

5. LEARN and document:
   - Document what failed
   - Document successful recovery approach
   - Update task with lessons learned
```

## Specific Loop Recovery Examples

### Example 1: Import Resolution Loop
**Symptom**: Agent keeps trying to import non-existent modules
**Recovery**:
- Manually verify available imports with `npm ls`
- Provide explicit import statements
- Or implement without the problematic dependency

### Example 2: Type Error Loop
**Symptom**: Agent repeatedly tries to fix TypeScript errors unsuccessfully
**Recovery**:
- Temporarily use `@ts-expect-error` with explanation
- Implement with simpler types first
- Or split into smaller, typed functions

### Example 3: Test Failure Loop
**Symptom**: Agent keeps modifying code but tests still fail
**Recovery**:
- Focus on understanding test requirements first
- Implement minimal code to pass one test
- Or temporarily skip test with clear documentation

### Example 4: Build Configuration Loop
**Symptom**: Agent stuck modifying config files
**Recovery**:
- Revert config changes
- Use default configuration
- Or manually set correct configuration

### Example 5: Circular Dependency Loop
**Symptom**: Agent trying to resolve circular imports
**Recovery**:
- Identify the cycle explicitly
- Refactor to shared interface/type
- Or use dependency injection pattern

## Implementation Guidelines (Enhanced)

1. **Research with Timeout**:
   - Set 3-minute limit for research phase
   - If no clear pattern found, try simplest approach

2. **Plan with Escape Routes**:
   - Include "if this fails, then..." in todo items
   - Mark high-risk items explicitly
   - Plan alternatives upfront

3. **Implement with Guards**:
   - Add validation before operations
   - Check for infinite loops in recursive code
   - Verify external dependencies exist

4. **Test with Limits**:
   - Maximum 3 test run attempts
   - If tests fail repeatedly, analyze test not code
   - Consider test might be wrong, not implementation

5. **Commit with Recovery Points**:
   - Commit working state before risky changes
   - Use `git stash` for experimental approaches
   - Maintain clean rollback points

## Parallelization with Safety

**Safe Parallel Execution**:
- Limit to 3 concurrent agents maximum
- Monitor all agents from orchestrator
- Kill any agent showing loop symptoms
- Reduce parallelization if issues detected

**Progressive Parallelization**:
1. Start with single agent for complex task
2. If successful, add parallel agents for simple tasks
3. If any issues, revert to sequential
4. Document parallel-safe vs sequential-only tasks

## Success Metrics

Track and optimize for:
- Tasks completed vs tasks attempted
- Average time per task (detect degradation)
- Loop detection rate (should decrease over time)
- Recovery success rate (should increase)
- Build stability (should remain high)

## Continuous Execution Protocol

### Task Master Completion Loop

The orchestrator must follow this continuous execution pattern:

```python
while pending_tasks_exist():
    1. Get current pending tasks from Task Master
    2. Deploy executors for available tasks (respecting dependencies)
    3. Monitor for completion or stuck agents
    4. Handle stuck agents with recovery strategies
    5. Mark completed tasks as done
    6. Report progress: "Completed X of Y total tasks"
    7. Continue to next batch

# Only exit when:
# - All tasks marked as "done"
# - OR remaining tasks are "blocked" with documented reasons
# - OR user explicitly interrupts
```

### Progress Reporting Requirements

Every 5 completed tasks, report:
- Tasks completed: X/Y (Z%)
- Currently executing: [list of in-progress tasks]
- Blocked tasks: [list with reasons]
- Estimated time to complete remaining tasks

### Handling Task Master Updates

After each batch of 10 tasks:
1. Run `mcp__task-master-ai__get_tasks` to check for new tasks
2. If new tasks added, include them in execution plan
3. Update total count and continue execution

### Completion Verification

Before declaring completion:
1. Run final check: `mcp__task-master-ai__get_tasks --status=pending`
2. Verify no pending tasks remain
3. Document any blocked tasks with clear reasons
4. Generate completion report with statistics

## Final Safety Rules

1. **Never let an agent run more than 10 minutes** without explicit approval
2. **Never retry the same approach more than 3 times**
3. **Always have a simpler fallback ready**
4. **Always preserve working state before risky operations**
5. **Always document what didn't work** for future agents
6. **Kill stuck agents immediately** - don't hope they recover
7. **Prioritize build stability** over feature completion
8. **When in doubt, simplify** rather than complexify
9. **NEVER STOP until all Task Master tasks are complete** - this is mandatory
10. **Track and report progress continuously** - users need visibility

Remember: The goal is 100% task completion. It's better to mark tasks as blocked with clear reasons than to stop prematurely. Use progressive enhancement - simple working solution first, then improve. Continue until the Task Master queue is empty.
