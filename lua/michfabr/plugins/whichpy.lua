return {
    "neolooong/whichpy.nvim",
    dependencies = {
        -- optional for dap
        -- "mfussenegger/nvim-dap-python",
        -- optional for picker support
        "ibhagwan/fzf-lua",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
    },
    init = function ()
        -- configure brazil python interpreter
        vim.keymap.set("n", "<leader>bpi", function ()
            local command = "brazil-path testrun.runtimefarm"
            local result = vim.fn.system(command)

            local function trim(s)
                    return string.gsub(s, '^%s*(.-)%s*$', '%1')
            end
            local function last_line(str)
                return str:match(".*\n(.*)$") or str
            end

            local python_interpreter_path = last_line(trim(result)) .. "/bin/python"

            vim.cmd({ cmd = "WhichPy", args = { "select", python_interpreter_path } })
        end, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>bpr", ':WhichPy reset<cr>', { noremap = true, silent = true })
    end
}
