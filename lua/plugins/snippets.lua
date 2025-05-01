return {
    {
        'saghen/blink.cmp',
        -- please test on `main` if possible
        -- otherwise, remove this line and set `version = '*'`
        opts = {
            -- leads to crashes - https://github.com/Saghen/blink.cmp/issues/1381
            completion = {
                ghost_text = { enabled = false },
            },
        },
    },
}
