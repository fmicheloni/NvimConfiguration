## Prerequisites
1. Neovim 0.12
2. Install `fzf`
3. Install `ripgrep`
4. Install `fd`
5. Install `node`. Use a node package manager.

## Useful use cases


### Search and Replace (single file)
1. Search for the pattern: `/vim.keymap.set` (Press Enter).
2. Type `cgn` (This stands for Change Go Next. It searches for the next match, visually selects it, and puts you in Insert mode).
3. Type your replacement.
4. Press `<Esc>`.
5. Now, simply press `.` (the dot command) to jump to the next occurrence and replace it instantly. Press `n` if you want to skip one.
