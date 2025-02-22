return {
    {
        "catppuccin/nvim",
        lazy = false,
        opts = {
            flavour = "latte",
            transparent_background = false,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
                notify = true,
                mini = true,
            },
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
