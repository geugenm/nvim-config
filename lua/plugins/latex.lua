return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "ltex-ls", -- Grammar/spelling checker for markup languages
                "ltex-ls-plus", -- Enhanced version of ltex-ls
                "bibtex-tidy", -- BibTeX formatter and validator
                "digestif", -- Linter/formatter for TeX/LaTeX
                "latexindent", -- Indentation tool for LaTeX
                "tectonic", -- Modern LaTeX engine
                "tex-fmt", -- TeX formatter
                "texlab", -- LaTeX language server
                "textlsp", -- Language server for TeX
                "vale", -- Prose linter
            },
        },
    },
}
