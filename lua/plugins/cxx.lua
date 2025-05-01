return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {},
            },
        },
    },
    {
        "williamboman/mason.nvim",
        optional = true,
        lazy = true,
        opts = { ensure_installed = { "codelldb" } },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "cpp",
            },
        },
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = true,
            },
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },
}
