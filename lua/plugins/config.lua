return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                cpp = { "clang-format" },
                c = { "clang-format" },
                python = { "black" },
                rust = { "rustfmt" },
                json = { "prettierd" },
                cmake = { "cmake_format" },
                yaml = { "prettierd", "prettier" },
            },
        },
    },
}
