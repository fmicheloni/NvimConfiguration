## Prerequisites
1. Neovim 0.12
2. Install `fzf`
3. Install `ripgrep`
4. Install `fd`
5. Install `node`. Use a node package manager.

## Useful use cases


### Reviewing changed files

After changes, you can use this loop to review before committing (very useful with agentic AIs such as Claude Code):

1. `<leader>fg` — fzf git status: fuzzy-pick any changed file, preview the diff on the right, `<CR>` to jump to it.
2. `<leader>gd` — open diffview: file list on the left (`<Tab>`/`<S-Tab>` to cycle), side-by-side diff on the right.
3. `]c` / `[c` — jump between hunks within the current file.
4. `<leader>hs` / `<leader>hr` — stage or reset individual hunks.
5. `<leader>gq` — close diffview when done.

---

### Search and Replace (single file)
1. Search for the pattern: `/vim.keymap.set` (Press Enter).
2. Type `cgn` (This stands for Change Go Next. It searches for the next match, visually selects it, and puts you in Insert mode).
3. Type your replacement.
4. Press `<Esc>`.
5. Now, simply press `.` (the dot command) to jump to the next occurrence and replace it instantly. Press `n` if you want to skip one.
