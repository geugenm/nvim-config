return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "ltex-ls", -- Grammar/spelling checker
                "ltex-ls-plus", -- Enhanced version of ltex-ls
                "markdown-toc", -- Table of contents generator
                "markdownlint-cli2", -- Markdown linter
                "marksman", -- Markdown language server
                "prettier", -- General code formatter
                "prettierd", -- Prettier as a daemon for better performance
                "vale", -- Prose linter
            },
        },
    },
}
