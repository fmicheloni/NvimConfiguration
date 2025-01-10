return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    init = function()
        require('bufferline').setup{
            options = {
                hover = {
                    enabled = false,
                }
            }
        }
    end
}
