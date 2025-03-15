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
    init = function()
        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     group = vim.api.nvim_create_augroup("WhichpyBufEnter", { clear = true }),
        --     pattern = "*.py",
        --     callback = function ()
        --         -- TODO: check if file is in specific interpreter path and configure it
        --         require("notify")(vim.api.nvim_buf_get_name(0))
        --     end
        -- })

        -- configure brazil python interpreter
        vim.keymap.set("n", "<leader>pi", function()
                local pyrightconfig = vim.fn.findfile("pyrightconfig.json", ".;")
                local filecontents = vim.fn.readfile(pyrightconfig)
                local json = vim.json.decode(vim.fn.join(filecontents, "\n"))
                if json == nil then
                    error("No valid pyrightconfig found")
                end
                local python_interpreter_path = json["venvPath"] .. "/" .. json["venv"] .. "/bin/python"

                vim.cmd({ cmd = "WhichPy", args = { "select", python_interpreter_path } })
            end,
            { noremap = true, silent = true, desc = "Will try to configure the project interpreter from pyright config" })
    end
}
