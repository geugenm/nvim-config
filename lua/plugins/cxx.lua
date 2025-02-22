return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "cpp" } },
    },
    {
        "p00f/clangd_extensions.nvim",
    },
    {
        "hrsh7th/nvim-cmp",
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {},
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
            opts = { ensure_installed = { "codelldb" } },
        },
    },
}
