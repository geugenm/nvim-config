return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "dockerfile" } },
    },
    {
        "mason.nvim",
        opts = { ensure_installed = { "hadolint" } },
    },
}
