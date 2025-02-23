---@type LazySpec[]
return {
    { "b0o/SchemaStore.nvim", lazy = true, version = false },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "yaml" },
        },
    },
}
