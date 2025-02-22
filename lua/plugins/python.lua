return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "ninja", "rst", "python" } },
    },
    {
        "nvim-neotest/neotest-python",
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            if vim.fn.has("win32") == 1 then
                require("dap-python").setup(
                    LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe")
                )
            else
                require("dap-python").setup(
                    LazyVim.get_pkg_path("debugpy", "/venv/bin/python")
                )
            end
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, "black")
        end,
    },
}
