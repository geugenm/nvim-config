return {
    {
        'saghen/blink.cmp',
        optional = true,
        opts = function(_, opts)
            -- Return early
            if include_in_completion then
                opts.snippets = { preset = 'mini_snippets' }
                return
            end

            -- Standalone --
            local blink = require('blink.cmp')
            expand_select_override = function(snippets, insert)
                -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
                blink.cancel()
                vim.schedule(function()
                    MiniSnippets.default_select(snippets, insert)
                end)
            end
            --
            -- Blink performs a require on blink.cmp.sources.snippets.default
            -- By removing the source, that default engine will not be used
            opts.sources.default = vim.tbl_filter(function(source)
                return source ~= 'snippets'
            end, opts.sources.default)
            opts.snippets = { -- need to repeat blink's preset here
                expand = function(snippet)
                    expand_from_lsp(snippet)
                    blink.resubscribe()
                end,
                active = function()
                    return MiniSnippets.session.get(false) ~= nil
                end,
                jump = function(direction)
                    jump(direction == -1 and 'prev' or 'next')
                end,
            }
        end,
    },
}
