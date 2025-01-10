-- TODO: this is a todo example
return {
    'numToStr/Comment.nvim',
    opts = {
    },
    init = function()
        local esc = vim.api.nvim_replace_termcodes(
            '<ESC>', true, false, true
        )

        vim.keymap.set("n", "<C-/>", function()
            require("Comment.api").toggle.linewise.current()
        end, {noremap = true, silent = true})
        vim.keymap.set("v", "<C-/>", function()
           vim.api.nvim_feedkeys(esc, 'nx', false)
           require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end, {noremap = true, silent = true})
    end
}
