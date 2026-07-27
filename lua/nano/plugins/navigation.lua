--------------------------
-- OIL
--------------------------
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  default_file_explorer = true,
  -- Let LSP servers (e.g. vtsls) update imports when files are moved/renamed
  -- in Oil. `enabled` is already Oil's default; the key addition here is
  -- autosave_changes, so the auto-updated imports are written to disk.
  -- "unmodified" = only auto-save files you weren't actively editing.
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = "unmodified",
  },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-p>"] = "actions.preview",
    ["q"] = "actions.close",
    ["<leader>r"] = "actions.refresh",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>-", function()
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  -- Calculate 1/3 of the total columns
  local width = math.floor(vim.o.columns / 3)
  vim.cmd("vertical resize " .. width)
  require("oil").open()
end, { desc = "Open Oil in a vertical split" })

--------------------------
-- FZF
--------------------------
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

local fzf = require("fzf-lua")

fzf.setup({
  "fzf-native",
  winopts = {
    height = 0.85,
    width = 0.80,
    preview = {
      layout = 'flex',
    },
  },
  previewers = {
    builtin = {
      syntax = true,
      syntax_limit_b = 1024 * 500, -- Disable syntax for files > 500KB
    },
  },
})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "fzf: Fuzzy find files" })
vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "fzf: Fuzzy find git files" })
vim.keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "fzf: Live grep (search text)" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "fzf: Fuzzy find open buffers" })
vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "fzf: Resume last search" })
vim.keymap.set("n", "<leader>fg", fzf.git_status, { desc = "fzf: Git status (changed files)" })

--------------------------
-- Harpoon
--------------------------
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  }
})

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: mark buffer" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: jump to buffer 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: jump to buffer 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: jump to buffer 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: jump to buffer 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-p>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
vim.keymap.set("n", "<M-n>", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
