---
allowed-tools: all
description: Evidence-based codebase cleanup with parallel analysis and safety verification
---

# /clean

**SPEED IS CRITICAL - MAXIMUM PARALLEL AGENT USAGE REQUIRED!**

## Arguments Integration

**Task Arguments**: ARGUMENTS$

**Apply cleanup protocol to arguments:**
1. Extract specific cleanup intensity level from user description
2. Verify all mentioned directories exist with Read tool
3. Note user constraints and safety preferences

---

**MANDATORY PRE-CLEANUP ANALYSIS**
1. Re-read CLAUDE.md RIGHT NOW
2. Understand project structure completely
3. Identify critical files that must never be touched
4. Create comprehensive safety assessment

**ZERO ASSUMPTIONS ABOUT PROJECT STRUCTURE**

## Phase 1: Rapid Multi-Agent Discovery

### Immediate Parallel Agent Spawning
**MANDATORY FIRST STEP: Spawn 6+ agents in parallel for comprehensive analysis**

**IMMEDIATELY spawn agents in parallel:**
- Agent 1: Scan file system for obvious junk files (*.tmp, *.log, *.bak, .DS_Store, etc.)
- Agent 2: Analyze package dependencies for unused packages across all manifests
- Agent 3: Detect dead code and unused imports via static analysis
- Agent 4: Check git history for files not touched in 6+ months
- Agent 5: Analyze build system to understand what's actually used/referenced
- Agent 6: Scan for duplicate code patterns and redundant files
- Agent 7: Identify configuration bloat and unused settings
- Agent 8: Look for test pollution and obsolete test files

**Each agent reports back with findings for rapid processing**

## Phase 2: Evidence Collection & Risk Assessment

### Parallel Evidence Gathering
**IMMEDIATELY spawn evidence collection agents:**
- Agent 1: Verify unused imports with comprehensive search analysis
- Agent 2: Confirm dead code with reference checking across codebase
- Agent 3: Validate unused dependencies with build system analysis
- Agent 4: Cross-reference git history with current usage patterns
- Agent 5: Verify junk files with file system and build output analysis
- Agent 6: Confirm duplicate code with semantic analysis

### Dynamic Risk Classification
**For each cleanup target, agents classify as:**

**SAFE REMOVAL** (No Risk, High Confidence)
- **Criteria**: Multiple evidence sources, obvious junk patterns, no references found
- **Examples**: *.tmp, *.log, *.bak, .DS_Store, Thumbs.db, *.swp, build artifacts
- **Evidence Required**: File pattern match + no recent access + not in build system

**PROBABLY SAFE** (Low Risk, Medium Confidence)
- **Criteria**: Strong evidence but some uncertainty, unused imports/code
- **Examples**: Unused imports, dead functions, deprecated config files
- **Evidence Required**: Static analysis + search verification + git history

**RISKY REMOVAL** (High Risk, Requires Verification)
- **Criteria**: Uncertain usage, potential impact, requires deep analysis
- **Examples**: Potentially unused modules, old migration files, legacy code
- **Evidence Required**: Multiple verification methods + user approval + testing

**STRUCTURAL CLEANUP** (Variable Risk, Organizational)
- **Criteria**: Code organization, duplicate consolidation, file restructuring
- **Examples**: Duplicate code removal, file reorganization, folder structure
- **Evidence Required**: Semantic analysis + impact assessment + comprehensive testing

## Phase 3: Parallel Safety Verification

### Comprehensive Safety Analysis
**IMMEDIATELY spawn safety verification agents:**
- Agent 1: Verify no critical dependencies will be broken
- Agent 2: Confirm no runtime references exist via dynamic analysis
- Agent 3: Check build system dependencies and outputs
- Agent 4: Validate test suite won't be affected
- Agent 5: Ensure no configuration dependencies are broken
- Agent 6: Verify no deployment or CI/CD dependencies

### Multi-Source Evidence Requirements
**For each cleanup target, require multiple evidence sources:**
- **Static Evidence**: No references found via comprehensive search
- **Dynamic Evidence**: Not referenced in build outputs or import chains
- **Historical Evidence**: Not modified or accessed recently
- **Contextual Evidence**: Matches known safe removal patterns
- **Build Evidence**: Not required by build system or deployment

## Phase 4: Cleanup Execution Strategy

### Present Findings in Structured Format

**CLEANUP ANALYSIS RESULTS**
- File system scan results with evidence scores
- Dependency analysis with usage verification
- Dead code detection with reference checking
- Git history analysis with access patterns
- Build system analysis with requirement mapping

**CLEANUP RECOMMENDATIONS**

**SAFE REMOVAL** (Immediate Implementation)
- [Dynamic list based on evidence collection]
- **Risk Level**: Minimal
- **Evidence Score**: High (3+ sources)
- **Estimated Impact**: None

**PROBABLY SAFE** (Recommended Implementation)
- [Dynamic list based on evidence collection]
- **Risk Level**: Low
- **Evidence Score**: Medium (2+ sources)
- **Estimated Impact**: Very Low

**RISKY REMOVAL** (Requires Approval)
- [Dynamic list based on evidence collection]
- **Risk Level**: High
- **Evidence Score**: Low (1 source)
- **Estimated Impact**: Potential

**STRUCTURAL CLEANUP** (Organizational)
- [Dynamic list based on evidence collection]
- **Risk Level**: Variable
- **Evidence Score**: Depends on change
- **Estimated Impact**: Organizational

## Phase 5: Parallel Implementation

### Cleanup Execution with Parallel Processing
**Based on user selections, spawn agents per risk tier:**

**SAFE REMOVAL**: Remove temporary files, OS junk, log files, editor backups, empty directories
**PROBABLY SAFE**: Remove unused imports, dead code, unused dependencies, deprecated config, obsolete tests
**RISKY REMOVAL**: Create backups first, remove with extensive verification, test incrementally, document for restoration
**STRUCTURAL CLEANUP**: Consolidate duplicates, reorganize files, optimize folders, merge configs

## Phase 6: Parallel Verification & Testing

### Comprehensive Validation Protocol
**After each cleanup batch, spawn validation agents:**
1. **Build verification** - Ensure project still builds correctly
2. **Test suite execution** - All tests must pass
3. **Dependency validation** - All imports resolve correctly
4. **Configuration verification** - All configs still valid
5. **Runtime testing** - No runtime errors introduced
6. **Performance validation** - No performance regressions

### Success Metrics & Rollback
**Track cleanup effectiveness:**
- **Files removed** - Count and size of cleaned files
- **Dependencies cleaned** - Unused packages removed
- **Code reduction** - Lines of dead code removed
- **Organization improvement** - Structure optimization
- **Build performance** - Faster build times
- **Test performance** - Faster test execution

## Emergency Rollback Procedures
**If any cleanup causes issues:**
1. **Immediate rollback** via git (restore from pre-cleanup commit)
2. **Root cause analysis** - Why did the cleanup fail?
3. **Evidence re-evaluation** - Was the evidence insufficient?
4. **Alternative approach** - Different cleanup strategy needed?
5. **User notification** - Clear explanation of what happened

## Cleanup Intensity Levels

### Light Clean (Safe & Fast)
Remove temporary files, build artifacts, OS junk, log files, editor backups.

### Medium Clean (Moderate Risk)
Light clean + unused imports, dead code, unused dependencies, deprecated configuration, obsolete tests.

### Deep Clean (Higher Risk)
Medium clean + consolidate duplicate code, reorganize file structure, remove potentially unused modules, clean legacy code.

### Aggressive Clean (Maximum Risk)
Deep clean + remove all potentially unused modules, major restructuring, consolidate all configuration, optimize entire project structure.

## Universal Cleanup Patterns

### Language-Agnostic Junk Detection
- **Temporary files** - *.tmp, *.bak, *.orig, *.swp, *~, *.backup
- **Log files** - *.log, *.out, debug.*, trace.*, error.*
- **OS cruft** - .DS_Store, Thumbs.db, desktop.ini
- **Editor files** - *.swp, *.swo, *~, .#*, *.sublime-*
- **Build artifacts** - dist/, build/, target/, .cache/, *.o, *.class
- **Package caches** - node_modules/ (if package.json exists), .pnpm-store/

### Technology-Specific Cleanup
- **JavaScript/Node** - node_modules, dist, .cache
- **Python** - __pycache__, *.pyc, .pytest_cache
- **Java** - target/, *.class, .gradle/
- **Rust** - target/, Cargo.lock conflicts
- **Go** - vendor/, *.test binaries
- **Docker** - dangling images, unused volumes

## Success Criteria
- All cleanup operations completed safely
- No functionality broken or impacted
- Build and test systems still working
- Significant cleanup achieved (files/dependencies removed)
- Project organization improved
- User approves all changes made
- Clear rollback instructions provided
