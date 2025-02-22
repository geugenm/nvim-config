return {

    {
        "Civitasv/cmake-tools.nvim",
        lazy = true,
        opts = {
            cmake_regenerate_on_save = true,
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_options = {},
            cmake_virtual_text_support = true,
        },
    },
    {
        "mason.nvim",
        opts = { ensure_installed = { "cmakelang", "cmakelint" } },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                neocmake = {},
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "cmake" } },
    },
}
