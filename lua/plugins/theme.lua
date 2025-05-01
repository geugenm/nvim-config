return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'latte', -- This sets the light version
            background = {
                light = 'latte',
                dark = 'mocha',
            },
            -- Add any other customizations you want
            transparent_background = false,
            show_end_of_buffer = false,
            styles = {
                comments = { 'italic' },
                conditionals = { 'italic' },
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
                nvimtree = true,
            },
        },
    },
    {
        'LazyVim/LazyVim',
        opts = {
            colorscheme = 'catppuccin',
        },
    },
}
