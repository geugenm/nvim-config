return {
    -- малако
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
                yaml = { "prettierd" },
                javascript = { "prettierd" },
            },
        },
    },
    { "b0o/SchemaStore.nvim", lazy = true, version = false },
    { "ThePrimeagen/refactoring.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "json",
                "yaml",
                "lua",
                "markdown",
                "markdown_inline",
                "query",
                "regex",
                "vim",
                "dockerfile",
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
                "hadolint",
                "sonarlint-language-server",
            },
        },
    },
}
