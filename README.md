## Prerequisites
1. Neovim 0.12
2. Install `fzf`
3. Install `ripgrep`
4. Install `fd`
5. Install `node`. Use a node package manager.
6. Install `tree-sitter-cli` (required by nvim-treesitter to compile parsers): `npm install -g tree-sitter-cli`
7. A C compiler (`cc`/`gcc`) in your `PATH`, needed by `tree-sitter-cli` to build parsers.

## Rust (rust-analyzer)

Not managed by Mason — we use the rustup binary so its proc-macro ABI matches the
active toolchain. On each machine (macOS/Linux, rustup install):

```sh
rustup component add rust-analyzer   # required
rustup component add clippy          # optional: on-save diagnostics
```

`lsp/rust_analyzer.lua` runs `~/.cargo/bin/rust-analyzer`. Keep it current with `rustup update`.

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
