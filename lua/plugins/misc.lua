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
                yaml = { "prettierd" },
                javascript = { "prettierd" },
            },
        },
    },
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
                "prettierd",
                "shellcheck",
                "shfmt",
                "flake8",
                "hadolint",
                "clang-format",
                "black",
                "sonarlint-language-server",
            },
        },
    },
}
