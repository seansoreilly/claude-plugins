# Automatic Conventional Git Commit

Create a git commit with an automatically generated conventional commit message.

## Instructions

You are an automatic git commit helper. Follow this workflow:

1. **Analyze current state**:
   - Run `git status` to see what's staged
   - If nothing is staged, check for unstaged changes and stage them
   - Run `git diff --cached` to see the actual changes

2. **Automatically determine commit type** by analyzing the diff:
   - **feat**: New features, new components, new functionality
   - **fix**: Bug fixes, error handling improvements, issue resolution
   - **refactor**: Code restructuring, renaming, moving files without changing behavior
   - **perf**: Performance improvements, optimization
   - **docs**: Documentation changes (README, comments, markdown files)
   - **style**: Formatting, branding changes, UI text updates, whitespace
   - **test**: Adding or updating tests only
   - **chore**: Dependencies, build config, tooling, generated files

3. **Automatically determine scope** (optional):
   - Extract from file paths (e.g., `src/components/auth/` → `auth`)
   - Use the main component/feature being changed
   - Omit if changes span multiple unrelated areas

4. **Generate description**:
   - Analyze the actual code changes to understand what was done
   - Create concise description in imperative mood
   - Keep under 72 characters
   - Use lowercase, no period at end
   - Focus on *what* changed, not *why*

5. **Create commit message** using format:
   ```
   <type>[(<scope>)]: <description>

   [optional body if changes are complex]
   ```

6. **Execute commit**: Run `git add .` if needed, then `git commit -m "message"`

## Decision Logic

**Type Selection Priority:**
1. If files match `*.test.*` or `e2e/` or `__tests__/` → **test**
2. If files are `*.md`, `docs/`, or comments only → **docs**
3. If package.json, lockfiles, config files → **chore**
4. If only formatting/whitespace/branding text → **style**
5. If new files/functions/features added → **feat**
6. If fixing bugs, errors, or issues → **fix**
7. If restructuring without new features → **refactor**
8. If optimizing performance → **perf**

**Scope Detection:**
- Look at modified file paths
- Extract component name from path (e.g., `src/components/auth/Login.tsx` → `auth`)
- If multiple components, list them or omit scope
- Common scopes: ui, api, auth, db, config, deps, tests

## Examples of Automatic Analysis

**Example 1:**
```
Files: src/components/auth/Login.tsx, src/components/auth/Signup.tsx
Changes: Added JWT token validation
→ Type: feat (new functionality)
→ Scope: auth
→ Message: "feat(auth): add JWT token validation"
```

**Example 2:**
```
Files: src/utils/dateFormatter.test.ts, src/utils/stringHelper.test.ts
Changes: New test cases added
→ Type: test
→ Scope: utils
→ Message: "test(utils): add date and string formatter test cases"
```

**Example 3:**
```
Files: src/components/layout/Header.tsx
Changes: Changed "App Name" to "My App"
→ Type: style
→ Scope: layout
→ Message: "style(layout): update header branding text"
```

**Example 4:**
```
Files: package.json, package-lock.json
Changes: Updated dependencies
→ Type: chore
→ Scope: deps
→ Message: "chore(deps): update project dependencies"
```

## Important Notes

- **Never ask the user for input** - analyze and decide automatically
- **Be confident** - make the best decision based on the changes
- **Be concise** - keep commit messages short and clear
- **Use imperative mood** - "add" not "added", "fix" not "fixed"
- **Lowercase descriptions** - don't capitalize first word
- **No period at end** - conventional commits don't use periods
- **Stage all changes** if nothing is staged yet
- **Execute the commit** - don't just show the message, actually commit it

## Workflow Summary

```
1. Check git status
2. Stage changes if needed (git add .)
3. Analyze git diff --cached
4. Determine type automatically
5. Extract scope from file paths
6. Generate description from changes
7. Create commit message
8. Execute: git commit -m "message"
9. Show confirmation with git log --oneline -1
```

Execute this workflow automatically without asking any questions.
