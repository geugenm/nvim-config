return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                tex = { "latexindent" },
            },
        },
    },

    {
        "lervag/vimtex",
        lazy = false, -- lazy-loading will disable inverse search
    },
    {
        "neovim/nvim-lspconfig",
        optional = true,
        opts = {
            servers = {
                texlab = {
                    keys = {
                        {
                            "<Leader>K",
                            "<plug>(vimtex-doc-package)",
                            desc = "Vimtex Docs",
                            silent = true,
                        },
                    },
                },
            },
        },
    },
}
