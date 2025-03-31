return {
    {
        "williamboman/mason.nvim",
        optional = true,
        lazy = true,
        opts = { ensure_installed = { "codelldb" } },
    },
}
