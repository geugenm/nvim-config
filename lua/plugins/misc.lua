---@type LazySpec[]
return {
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
                "yaml",
            },
        },
    },
}
