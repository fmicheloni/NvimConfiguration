vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
--------------------------
-- Rose Pine colors
--------------------------

vim.pack.add({ "https://github.com/rose-pine/neovim" })

require("rose-pine").setup({
  variant = "moon",
  dark_variant = "moon",
})

vim.cmd("colorscheme rose-pine")

--------------------------
-- Git Signs
--------------------------
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require('gitsigns').setup {
  signs      = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Keep this true since you set signcolumn = 'yes'
  numhl      = false, -- Don't highlight line numbers (keep it clean)
  word_diff  = false, -- Inline word diffing (can be noisy, keep off by default)

  -- The "Magic": Keymaps for jumping between changes
  on_attach  = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation: Jump between hunks (changes)
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.nav_hunk('next') end)
      return '<Ignore>'
    end, { expr = true, desc = "Next Change" })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.nav_hunk('prev') end)
      return '<Ignore>'
    end, { expr = true, desc = "Previous Change" })

    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage Hunk" })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset Hunk" })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview Hunk" })
    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "Blame Line" })
  end
}

--------------------------
-- Diffview
--------------------------
vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({})

vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>",  { desc = "Git: Open diff view" })
vim.keymap.set("n", "<leader>gq", "<CMD>DiffviewClose<CR>", { desc = "Git: Close diff view" })
