require("michfabr.remap")
require("michfabr.lazy")
require("michfabr.set")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.guicursor = ""
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor"
vim.o.cursorline = true
vim.cmd([[
    highlight CursorLine cterm=NONE ctermbg=LightGray guibg=#2a283e
]])
vim.cmd([[
    highlight Cursor guifg=white guibg=white
]])

vim.g.python3_host_prog = "~/miniconda3/envs/pynvim/bin/python"

vim.filetype.add({ filename = { Config = "brazil-config" } })
