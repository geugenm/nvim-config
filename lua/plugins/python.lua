return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "basedpyright", -- Fast Python type checker
                "black", -- Python code formatter
                "debugpy", -- Python debugger
                "pylint", -- Python linter
                "sonarlint-language-server", -- Static code analyzer
            },
        },
    },
}
