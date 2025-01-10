local opts = {
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'markdown_inline',
    'javascript',
    'java',
    'typescript',
    'rust',
    'python',
    'json',
    'ssh_config',
    'bash',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

local function config()
  require('nvim-treesitter.configs').setup(opts)
end

return {
  'nvim-treesitter/nvim-treesitter',
  config = config,
  build = ':TSUpdate',
}

