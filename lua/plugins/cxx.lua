return {
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- clangd will be automatically installed with mason and loaded with lspconfig
                clangd = {},
            },
        },
    },
}
