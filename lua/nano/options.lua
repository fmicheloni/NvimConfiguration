local opt = vim.opt

opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Relative numbers for jumping
opt.shiftwidth = 4         -- Size of an indent
opt.tabstop = 4            -- Number of spaces tabs count for
opt.expandtab = true       -- Use spaces instead of tabs
opt.ignorecase = true      -- Ignore case in search patterns
opt.smartcase = true       -- ...unless I use a capital letter
opt.termguicolors = true   -- True color support
opt.cursorline = true      -- Highlight the current line
opt.splitbelow = true      -- Put new windows below
opt.splitright = true      -- Put new windows to the right
opt.scrolloff = 8          -- Keeps 8 lines visible above/below cursor when scrolling.
opt.updatetime = 50        -- Faster completion and UI updates.
opt.breakindent = true     -- Wrapped lines maintain the same indent level.
vim.opt.signcolumn = "yes" -- Avoid horizontal jump
