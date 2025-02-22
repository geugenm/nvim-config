---@type LazySpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "ninja", "rst", "python" } },
    },
    { "nvim-neotest/neotest-python" },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            local python_path = vim.fn.has("win32") == 1
                    and LazyVim.get_pkg_path(
                        "debugpy",
                        "/venv/Scripts/pythonw.exe"
                    )
                or LazyVim.get_pkg_path("debugpy", "/venv/bin/python")
            require("dap-python").setup(python_path)
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "black")
        end,
    },
}
