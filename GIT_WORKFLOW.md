# WakeAI Git Workflow Guide

This document outlines the recommended Git workflow for the WakeAI project, including daily practices, branching strategies, and common scenarios like rollbacks.

## Daily Workflow

### Morning Routine

Start your day with these steps to ensure you're working with the latest code:

1. **Morning Pull** (First thing when you start working):
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Review Changes**:
   - Check the commit history to see what changed since yesterday
   ```bash
   git log --since=yesterday
   ```

3. **Create or Continue Working Branch**:
   - For a new task:
   ```bash
   git checkout -b feature/descriptive-name
   ```
   - To continue on an existing branch:
   ```bash
   git checkout feature/existing-branch
   git pull origin feature/existing-branch  # If pushed previously
   ```

### Throughout the Day

1. **Regular Commits**:
   - Commit logical, complete chunks of work (not incomplete features)
   - Use descriptive commit messages
   ```bash
   git add .
   git commit -m "Add voice recognition service with basic command detection"
   ```

2. **Frequent Saving** (Even for incomplete work):
   - If you need to save work in progress that's not ready for a proper commit
   ```bash
   git add .
   git commit -m "WIP: Initial structure for alarm settings screen"
   ```

### Evening Wrap-up

1. **End-of-Day Push**:
   - Push your changes to the remote repository before ending your day
   ```bash
   git push origin your-branch-name
   ```

2. **Create Documentation Notes**:
   - Document any important decisions or challenges in code comments or documentation files
   - Commit these separately with clear messages
   ```bash
   git add DEVELOPMENT_NOTES.md
   git commit -m "Document hybrid approach performance considerations"
   ```

3. **Status Check**:
   - Review what you've accomplished and what's pending
   ```bash
   git status
   ```

## Branching Strategy

### Branch Types

1. **Main Branch** (`main`):
   - Always stable and deployable
   - Never commit directly to main
   - Protected by pull request reviews

2. **Feature Branches** (`feature/descriptive-name`):
   - Created for new features
   - Examples: `feature/morning-routine-ui`, `feature/voice-recognition`

3. **Bug Fix Branches** (`fix/descriptive-name`):
   - Created for bug fixes
   - Examples: `fix/alarm-crash`, `fix/voice-recognition-accuracy`

4. **Release Branches** (`release/version-number`):
   - Created when preparing for a release
   - Example: `release/1.0.0`

### Branch Naming Conventions

- Use lowercase and hyphens
- Be descriptive but concise
- Include ticket/issue numbers if applicable

Good examples:
- `feature/template-engine`
- `fix/speech-input-crash`
- `feature/user-onboarding-flow`

## Commit Messages

### Structure

Follow this format for commit messages:
```
Short summary (50 chars or less)

More detailed explanation if necessary. Keep line length to about 72 
characters. Explain what and why vs. how.

- Bullet points are okay
- Typically hyphen or asterisk is used

Ref: #123 (issue or pull request reference)
```

### Examples

Good commit messages:
```
Add speech preprocessing filter to remove filler words

Implemented the preprocessing functionality described in the Speech Input
Optimization Strategies document. This reduces token usage by ~30% by
removing common filler words while preserving context.

Ref: #42
```

```
Fix alarm not triggering on specific Android devices

The background service wasn't properly registered on Android 12+ due to
new OS restrictions. Updated the manifest and service registration to
comply with latest requirements.
```

## Code Reviews & Pull Requests

1. **Creating a Pull Request**:
   - Push your branch to GitHub
   ```bash
   git push origin your-branch-name
   ```
   - Create a PR on GitHub with a clear description of changes
   - Reference any related issues

2. **Before Merging**:
   - Ensure CI tests pass
   - Address all review comments
   - Rebase if necessary to resolve conflicts
   ```bash
   git checkout your-branch-name
   git pull --rebase origin main
   git push --force-with-lease origin your-branch-name
   ```

## Handling Common Scenarios

### Rolling Back Changes

#### 1. Undo Last Commit (Keeping Changes)

If you committed too early and want to undo the commit but keep the changes:
```bash
git reset --soft HEAD~1
```

#### 2. Undo Last Commit (Discarding Changes)

If you want to completely remove the last commit and its changes:
```bash
git reset --hard HEAD~1
```

#### 3. Reverting a Commit in History

If you need to undo a commit that's already been pushed:
```bash
git revert commit-hash
```

#### 4. Reverting to a Specific Version

To go back to a specific point in time:
```bash
# Find the commit you want
git log

# Create a new branch at that point
git checkout -b recovery-branch commit-hash

# Or reset main to that point (use with caution)
git checkout main
git reset --hard commit-hash
git push --force-with-lease origin main  # DANGER: Only use if absolutely necessary
```

### Handling Work in Progress

#### 1. Stashing Changes Temporarily

To save changes without committing:
```bash
git stash save "Meaningful description of your changes"

# Later, to apply the stashed changes
git stash list
git stash apply stash@{0}  # Or the number from the list
```

#### 2. Switching Branches with Unfinished Work

```bash
git stash
git checkout other-branch
# Do work on other branch
git checkout original-branch
git stash pop
```

### Resolving Merge Conflicts

1. **When a Pull Gives Conflicts**:
   ```bash
   # Edit the files to resolve conflicts
   git add resolved-file.dart
   git commit  # Commit the merge
   ```

2. **Using Visual Tools**:
   ```bash
   git mergetool  # If configured
   ```
   
   Or use VS Code's built-in merge conflict resolution tools.

## Best Practices

1. **Pull Before Push**:
   - Always pull latest changes before pushing
   ```bash
   git pull --rebase origin branch-name
   ```

2. **Keep Branches Short-lived**:
   - Complete and merge feature branches promptly
   - Don't let branches diverge too far from main

3. **Regular Cleanup**:
   - Delete merged branches
   ```bash
   git branch -d branch-name  # Local deletion
   git push origin --delete branch-name  # Remote deletion
   ```

4. **Use Tags for Releases**:
   ```bash
   git tag -a v1.0.0 -m "Version 1.0.0 release"
   git push origin v1.0.0
   ```

5. **Backup Important States**:
   - Tag significant milestones
   ```bash
   git tag -a milestone-name -m "Description of this milestone"
   ```

6. **Document Special Procedures**:
   - Add notes in this file about project-specific Git procedures

## Git Configuration Tips

### Helpful Aliases

Add these to your `.gitconfig` for faster workflows:

```
[alias]
  st = status
  co = checkout
  br = branch
  ci = commit
  lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
  unstage = reset HEAD --
  last = log -1 HEAD
```

### Setting Up VS Code as Git Editor

```bash
git config --global core.editor "code --wait"
```

## Emergency Procedures

### When Something Goes Wrong

1. **Don't Panic** - Git keeps a reflog that tracks all changes
   ```bash
   git reflog  # See history of all Git operations
   ```

2. **Create a Backup Branch** before attempting fixes
   ```bash
   git branch backup-branch
   ```

3. **Get Expert Help** if uncertain about recovery steps

### Recovering Lost Work

If you've lost work and can't find it through normal means:
```bash
git reflog  # Find the hash of the state with your work
git checkout -b recovery hash-from-reflog
```

## Recommended Tools

- **VS Code Git Integration** - Built-in Git features
- **GitHub Desktop** - User-friendly GUI for Git operations
- **GitLens VS Code Extension** - Enhanced Git capabilities within VS Code

## GitHub Project Integration

### Using Issues for Task Tracking

1. Create issues for features, bugs, and tasks
2. Reference issues in commit messages and PRs using #issue-number
3. Close issues automatically through PRs with keywords:
   - "Closes #123", "Fixes #123", "Resolves #123"

## Conclusion

Following these Git practices will help maintain a clean, organized codebase and make it easier to track changes, collaborate, and recover from any issues that arise during development.

Remember: Commit often, push regularly, and always backup important work.
