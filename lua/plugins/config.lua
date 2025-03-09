return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                c = { "clang-format" },
                python = { "black" },
                rust = { "rustfmt" },
                json = { "prettierd" },
                cmake = { "cmake_format" },
                yaml = { "prettierd", "prettier" },
            },
        },
    },
    { "b0o/SchemaStore.nvim", lazy = true, version = false },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "yaml" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "dockerfile" } },
    },
    { "mason.nvim", opts = { ensure_installed = { "hadolint" } } },
    { "ThePrimeagen/refactoring.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "query",
                "regex",
                "vim",
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
            },
        },
    },
    { "Exafunction/codeium.nvim", lazy = true },
}
