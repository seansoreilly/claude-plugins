---
allowed-tools: all
description: Extensive UI testing with Playwright MCP using parallel subagents to test all paths until 99% confident
---

# /test-ui - Comprehensive UI Testing with Playwright

**COMPREHENSIVE UI TESTING MODE: DO NOT STOP UNTIL 99% CONFIDENT ALL PATHS ARE WORKING**

## Arguments Integration

**Target**: ARGUMENTS$

**Apply UI testing protocol to arguments:**
1. Store target URL/project path
2. Extract URL or project location from user description
3. Verify target is accessible (navigate to it first)
4. Store initial UI structure observations

---

## MANDATORY TESTING APPROACH

**You are NOT done testing until:**
- ALL navigation paths tested (100% coverage target)
- ALL form submissions working
- ALL buttons and links functional
- ALL error states handled gracefully
- ALL edge cases explored
- 99% confidence that UI is production-ready
- No UI simplification opportunities missed

**FORBIDDEN BEHAVIORS:**
- Testing only happy paths - Test error/edge cases too!
- "UI seems to work fine" - Test EVERY interaction!
- Stopping at first successful test - Keep testing!
- Ignoring UI simplification opportunities - Implement them!
- "Good enough" confidence - Need 99% confidence!

---

## MULTI-AGENT TESTING STRATEGY

### Phase 1: UI Structure Analysis (Sequential)
1. Navigate to target URL/project
2. Take screenshot and analyze page structure
3. Identify ALL interactive elements:
   - Buttons and links
   - Form fields and inputs
   - Dropdowns and selects
   - Modals and popups
   - Navigation items
   - Error/warning messages
4. Map out all possible user flows
5. Store complete UI structure map

### Phase 2: Parallel Subagent Spawning
**Create 4-6 parallel test agents, each focusing on:**

**Agent 1: Navigation & Links Testing**
- Test all links work and navigate correctly
- Test back/forward button functionality
- Test navigation menu items
- Test breadcrumbs (if present)
- Test deep linking if applicable
- Report any broken or missing navigation

**Agent 2: Form Testing**
- Test all form fields with valid data
- Test form field validation (empty, invalid format, etc.)
- Test form submission success flows
- Test form error handling
- Test file uploads (if present)
- Test form reset/clear functionality

**Agent 3: Interaction & State Testing**
- Test button clicks and their outcomes
- Test toggles, checkboxes, radio buttons
- Test hover states and tooltips
- Test loading states (if present)
- Test state persistence (refresh page, etc.)
- Test modal open/close functionality

**Agent 4: Error & Edge Case Testing**
- Test error message displays
- Test network error scenarios (simulate with playwright)
- Test timeout behaviors
- Test empty state displays
- Test boundary conditions (max/min values)
- Test special characters in inputs

**Agent 5: Responsive & Accessibility Testing**
- Test on different viewport sizes (mobile, tablet, desktop)
- Test keyboard navigation (tab through elements)
- Test screen reader compatibility (if applicable)
- Test color contrast ratios
- Test focus management

**Agent 6: Performance & UX Testing**
- Test page load times
- Test scroll performance
- Test animation smoothness
- Test button feedback (visual response)
- Test form field feedback

### Phase 3: Issue Discovery & Iteration
**For EACH issue found:**
1. Document the issue with:
   - Description of problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshot/video evidence
2. Determine root cause (code issue? config issue? design issue?)
3. IMMEDIATELY fix the issue
4. Re-test the fix
5. Update test plan with regression test

### Phase 4: UI Simplification Opportunities
**If you identify ways to simplify the UI:**
1. Document the opportunity with rationale
2. Implement the simplification (modify code/config)
3. Test that simplification works
4. Verify it maintains functionality
5. Confirm it improves UX

### Phase 5: Confidence Building
**Keep testing until you can confidently say:**
- "I've tested X% of possible user flows"
- "I've found and fixed Y issues"
- "I've explored Z edge cases"
- "I'm 99% confident all paths work correctly"

---

## EXECUTION WORKFLOW

**Step 1: Initial Analysis**
```
Navigate to target
Take screenshot
Analyze UI structure
Create complete flow map
```

**Step 2: Spawn Parallel Agents**
```
"I've identified the UI structure. Now spawning 6 parallel test agents:
- Agent 1: Testing all navigation paths (5+ flows)
- Agent 2: Testing all forms (submit, validate, error states)
- Agent 3: Testing interactive elements (clicks, toggles, states)
- Agent 4: Testing error cases and edge conditions
- Agent 5: Testing responsive design and accessibility
- Agent 6: Testing performance and UX feedback

I'll coordinate results and iterate on any issues found..."
```

**Step 3: Coordinate & Iterate**
```
- Collect results from all agents
- Categorize issues by severity/type
- IMMEDIATELY fix all issues found
- Re-test fixed areas
- Continue spawning agents until no new issues found
```

**Step 4: Confidence Assessment**
```
- Count total UI paths tested
- Count issues found and fixed
- Estimate coverage percentage
- If < 99% confidence: spawn more focused tests
- If = 99% confidence: create comprehensive test summary
```

---

## ITERATION CYCLE

When agents report issues:

1. **Issue Analysis**
   ```
   "I found 3 issues:
   1. [Issue A] - severity: HIGH
   2. [Issue B] - severity: MEDIUM
   3. [Issue C] - severity: LOW

   Now fixing all issues in priority order..."
   ```

2. **Parallel Fixes**
   ```
   "Spawning agents to fix all issues:
   - Agent F1: Fix Issue A (code change)
   - Agent F2: Fix Issues B & C (config/styling)

   After fixes, I'll re-test all affected areas..."
   ```

3. **Re-test**
   ```
   "Re-testing all areas affected by fixes:
   - Re-testing Issue A fix
   - Re-testing Issue B fix
   - Re-testing Issue C fix

   New tests reveal [N] new issues, re-iterating..."
   ```

4. **Loop Until Stable**
   ```
   "No new issues found in re-testing.
   Performing final comprehensive tests to reach 99% confidence..."
   ```

---

## STUCK IN A LOOP? ULTRATHINK

**If you find yourself testing the same issues repeatedly:**

Use sequential thinking to:
1. Analyze why the issue keeps occurring
2. Identify the root cause (not the symptom)
3. Find a more fundamental fix
4. Consider UI simplification to prevent the issue entirely
5. Design a workaround if direct fix is blocked

**Common loop patterns & fixes:**
- **Validation loop**: Simplify validation or improve error messages
- **Navigation loop**: Consolidate navigation options or improve routing
- **State loop**: Implement proper state management
- **API loop**: Cache results or implement retry logic

---

## COMPLETION CRITERIA

**You are DONE when:**

1. **Coverage**: Tested 95%+ of UI paths
2. **Stability**: No issues found in final 2 test iterations
3. **Confidence**: 99% confident all working paths are identified
4. **Fixes**: All found issues are fixed and verified
5. **Optimization**: All identified simplification opportunities implemented
6. **Documentation**: Complete test report showing:
   - Number of paths tested
   - Number of issues found and fixed
   - Estimated coverage percentage
   - Critical/high severity issues (should be 0)
   - UI improvements implemented

---

## TESTING TEMPLATE

**For each test agent, provide:**
```
Component/Path: [Name]
Test Cases: [Count]
Passed: [Count]
Failed: [Count]
Issues Found: [List]
Status: PASS / FAIL / ISSUES FOUND
```

**Final Report:**
```
UI TESTING COMPLETE

Total Paths Tested: X
Total Test Cases: Y
Issues Found: Z
Issues Fixed: Z
Estimated Coverage: 95%+
Confidence Level: 99%

Critical Issues: 0
High Severity Issues: 0
Medium Severity Issues: [N]
Low Severity Issues: [N]

UI Simplifications Implemented: [N]

Status: PRODUCTION READY
```

---

## REMEMBER

- **This is NOT a quick smoke test** - This is comprehensive testing
- **Multiple agents in parallel** - Don't test sequentially
- **ITERATE until stable** - Keep testing and fixing
- **Fix issues immediately** - Don't just report them
- **99% confidence target** - Not "good enough"
- **Simplify when possible** - Improve UX while testing

**NOW: Starting comprehensive UI testing with parallel subagents...**

I will navigate to the target, analyze the UI structure, spawn multiple parallel test agents, iterate on any issues found, and keep testing until I'm 99% confident all UI paths work correctly. Let me begin!
