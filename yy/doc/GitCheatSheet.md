# Git Cheatsheet

## Creating Repositories

```shell
# create new repository in current directory
git init
# clone a remote repository
git clone [url]
# for example cloning the entire jquery repo locally
git clone https://github.com/jquery/jquery
```



## Branches and Tags

```sh
# List all existing branches with the latest commit comment 
git branch –av

# Switch your HEAD to branch
git checkout [branch]

# Create a new branch based on your current HEAD
git branch [new-branch]

# Create a new tracking branch based on a remote branch
#   New way:
git checkout <branch>
#   Or:
git checkout -b <branch> --track <remote>/<branch>
#   Or:
git checkout --track [remote/branch]
# for example track the remote branch named feature-branch-foo
git checkout --track origin/feature-branch-foo

# Delete a local branch
git branch -d [branch]

# Tag the current commit
git tag [tag-name]
```



## Local Changes

```sh
# List all new or modified files - showing which are to staged to be commited and which are not 
git status

# View changes between staged files and unstaged changes in files
git diff

# View changes between staged files and the latest committed version
git diff --cached
# only one file add the file name
git diff --cached [file]

# Add all current changes to the next commit
git add [file]

# Remove a file from the next commit
git rm [file]

# Add some changes in < file> to the next commit
# Watch these video's for a demo of the power of git add -p - http://johnkary.net/blog/git-add-p-the-most-powerful-git-feature-youre-not-using-yet/
git add -p [file]

# Commit all local changes in tracked  files
git commit –a
git commit -am "An inline  commit message"

# Commit previously staged changes
git commit
git commit -m "An inline commit message"

# Unstages the file, but preserve its contents

git reset [file]
```



## Commit History

```sh
# Show all commits, starting from the latest 
git log 

# Show changes over time for a specific file 
git log -p [file]

# Show who changed each line in a file, when it was changed and the commit id
git blame -c [file]
```



## Update and Publish

```sh
# List all remotes 
git remote -v

# Add a new remote at [url] with the given local name
git remote add [localname] [url]

# Get all changes from a remote, but don‘t integrate into them locally
git fetch [remote]

# Fetch and merge [remote-branch] into the branch you're on
git pull [remote] [remote-branch]

# Publish local changes to a remote 
git push [remote] [branch]

# Delete a branch on the remote 
git branch -dr [remote/branch]

# Publish your tags to a remote
git push --tags

```



## Merge & Rebase

```sh
# Merge [branch] into your current HEAD 
git merge [branch]

# Rebase your current HEAD onto [branch]
git rebase [branch]

# Abort a rebase 
git rebase –abort

# Continue a rebase after resolving conflicts 
git rebase –continue

# Use your configured merge tool to solve conflicts 
git mergetool

# Use your editor to manually solve conflicts and (after resolving) mark as resolved 
git add <resolved- file>
git rm <resolved- file>
```



## Undo

```sh
# Discard all local changes and start working on the current branch from the last commit
git reset --hard HEAD

# Discard local changes to a specific file 
git checkout HEAD [file]
# Or
git checkout -- [file]

# Revert a commit by making a new commit which reverses the given [commit]
git revert [commit]

# Reset your current branch to a previous commit and discard all changes since then 
git reset --hard [commit]

# Reset your current branch to a previous commit and preserve all changes as unstaged changes 
git reset [commit]

#  Reset your current branch to a previous commit and preserve staged local changes 
git reset --keep [commit]
```

## Rename local and remote branch

### Rename local 

```sh
# Switch to the local branch you want to rename:
git checkout <old_name>

# Rename the local branch:
git branch -m <new_name>
```

If you’ve already pushed the `<old_name>` branch to the [remote repository](https://linuxize.com/post/how-to-add-git-remotes/) , perform the next steps to rename the remote branch.

### Rename remote

```sh
# Push the `<new_name>` local branch and reset the upstream branch:
git push origin -u <new_name>
# Delete the `<old_name>` remote branch:
git push origin --delete <old_name>
```

- [How to Undo Last Git Commit](https://linuxize.com/post/undo-last-git-commit/)

### Git Version 2.x

| Command                      | New Files | Modified Files | Deleted Files | Description                                                |
| :--------------------------- | :-------- | :------------- | :------------ | :--------------------------------------------------------- |
| `git add -A`                 | ✔️         | ✔️              | ✔️             | Stage all (new, modified, deleted) files                   |
| `git add .`                  | ✔️         | ✔️              | ✔️             | Stage all (new, modified, deleted) files in current folder |
| `git add --ignore-removal .` | ✔️         | ✔️              | ❌             | Stage new and modified files only                          |
| `git add -u`                 | ❌         | ✔️              | ✔️             | Stage modified and deleted files only                      |

### Long-form flags:

- `git add -A` is equivalent to `git add --all`
- `git add -u` is equivalent to `git add --update`

## vimdiff cheat sheet

### git mergetool

In the middle file (future merged file), you can navigate between conflicts with `]c` and `[c`.

Choose which version you want to keep with `:diffget //2` or `:diffget //3` (the `//2` and `//3` are unique identifiers for the target/master copy and the merge/branch copy file names).

```
:diffupdate (to remove leftover spacing issues)
:only (once you’re done reviewing all conflicts, this shows only the middle/merged file)
:wq (save and quit)
git add .
git commit -m “Merge resolved”
```

If you were trying to do a `git pull` when you ran into merge conflicts, type `git rebase –continue`.

### vimdiff commands

```
]c :        - next difference
[c :        - previous difference
do          - diff obtain
dp          - diff put
zo          - open folded text
zc          - close folded text
:diffupdate - re-scan the files for differences
```