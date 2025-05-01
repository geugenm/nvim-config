return {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'prettier', -- General code formatter
                'prettierd', -- Prettier as daemon for better performance
                'sonarlint-language-server', -- Static code analyzer
                'yaml-language-server', -- YAML language server
            },
        },
    },
}
