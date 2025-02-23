---@type LazySpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "cpp" } },
    },
    { "p00f/clangd_extensions.nvim", lazy = true },
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sorting = opts.sorting or {}
            opts.sorting.comparators = opts.sorting.comparators or {}
            table.insert(
                opts.sorting.comparators,
                1,
                require("clangd_extensions.cmp_scores")
            )
        end,
    },
    { "neovim/nvim-lspconfig", opts = { servers = { clangd = {} } } },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = { ensure_installed = { "codelldb" } },
            },
        },
    },
}
