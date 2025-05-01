return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "cpptools", -- Microsoft C++ tools
                "cpplint", -- Google's C++ linter
                "clang-format", -- C++ formatter
                "clangd", -- C++ language server
                "codelldb", -- LLDB-based debugger
                "sonarlint-language-server", -- Static code analyzer
            },
        },
    },
}
