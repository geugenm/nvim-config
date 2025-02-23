---@type LazySpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "ninja", "rst", "python" } },
    },
    { "nvim-neotest/neotest-python", lazy = true },
    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        keys = {
            {
                "<leader>dPt",
                function()
                    require("dap-python").test_method()
                end,
                desc = "Debug Method",
                ft = "python",
            },
            {
                "<leader>dPc",
                function()
                    require("dap-python").test_class()
                end,
                desc = "Debug Class",
                ft = "python",
            },
        },
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
        opts = { ensure_installed = { "black" } },
    },
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- basedpyright will be automatically installed with mason and loaded with lspconfig
                basedpyright = {},
            },
        },
    },
}
