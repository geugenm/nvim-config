return {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'ltex-ls', -- Grammar/spelling checker for markup languages
                'ltex-ls-plus', -- Enhanced version of ltex-ls
                'bibtex-tidy', -- BibTeX formatter and validator
                'digestif', -- Linter/formatter for TeX/LaTeX
                'latexindent', -- Indentation tool for LaTeX
                'tectonic', -- Modern LaTeX engine
                'tex-fmt', -- TeX formatter
                'texlab', -- LaTeX language server
                'textlsp', -- Language server for TeX
                'vale', -- Prose linter
            },
        },
    },
    {
        'lervag/vimtex',
        lazy = false, -- Load immediately for .tex files
        init = function()
            -- Core VimTeX settings
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_method = 'tectonic'
            vim.g.vimtex_compiler_tectonic = {
                options = {
                    '--synctex',
                    '--keep-logs',
                    '--keep-intermediates',
                },
            }
            -- Citation management
            vim.g.vimtex_complete_bib = {
                simple = true, -- Simple but fast completion
                menu_fmt = '@title by @author (@year)',
            }
            -- Performance optimizations
            vim.g.vimtex_fold_enabled = true
            vim.g.vimtex_fold_manual = true
            vim.g.vimtex_syntax_conceal_disable = false
        end,
    },
}
