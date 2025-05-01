-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function lumen_commit_push()
    local function log(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO)
    end

    local function run_cmd(cmd, opts)
        opts = opts or {}
        local stdout_data = {}
        local stderr_data = {}

        vim.fn.jobstart(cmd, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if data and #data > 0 then
                    for _, line in ipairs(data) do
                        if line ~= '' then
                            table.insert(stdout_data, line)
                        end
                    end
                end
            end,
            on_stderr = function(_, data)
                if data and #data > 0 then
                    for _, line in ipairs(data) do
                        if line ~= '' then
                            table.insert(stderr_data, line)
                        end
                    end
                end
            end,
            on_exit = function(_, code)
                if code == 0 then
                    if opts.on_success then
                        opts.on_success(stdout_data)
                    end
                else
                    local err = #stderr_data > 0
                            and table.concat(stderr_data, '\n')
                        or string.format('exited with code %d', code)
                    if opts.on_error then
                        opts.on_error(err)
                    else
                        log(
                            string.format('%s failed: %s', opts.name, err),
                            vim.log.levels.ERROR
                        )
                    end
                end
            end,
        })
    end

    local function commit_with_message(message)
        -- Commit changes
        run_cmd(
            string.format('git commit -m %s', vim.fn.shellescape(message)),
            {
                name = 'git commit',
                on_success = function()
                    log('commit successful')

                    -- Push changes
                    run_cmd('git push', {
                        name = 'git push',
                        on_success = function()
                            log('push successful')
                        end,
                        on_error = function(err)
                            log(
                                string.format('git push failed: %s', err),
                                vim.log.levels.ERROR
                            )
                        end,
                    })
                end,
                on_error = function(err)
                    log(
                        string.format('git commit failed: %s', err),
                        vim.log.levels.ERROR
                    )
                end,
            }
        )
    end

    local function edit_commit_message(initial_message)
        -- Create a scratch buffer for editing
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(buf, 'COMMIT_EDITMSG')
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { initial_message })

        -- Set buffer options
        vim.api.nvim_buf_set_option(buf, 'filetype', 'gitcommit')
        vim.api.nvim_buf_set_option(buf, 'buftype', 'acwrite')
        vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

        -- Create a split and show the buffer
        vim.cmd('vsplit')
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, buf)

        -- Set autocmd to handle when buffer is written and closed
        vim.api.nvim_create_autocmd('BufWritePost', {
            buffer = buf,
            callback = function()
                local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                local edited_message = table.concat(lines, '\n')
                -- Remove comments
                edited_message = edited_message
                    :gsub('^#.*\n', '')
                    :gsub('\n#.*', '')
                    :gsub('^%s*(.-)%s*$', '%1')

                if edited_message ~= '' then
                    vim.schedule(function()
                        vim.api.nvim_buf_delete(buf, { force = true })
                        commit_with_message(edited_message)
                    end)
                else
                    log('Empty commit message, aborting', vim.log.levels.WARN)
                end
                return true
            end,
            once = true,
        })

        -- Add some instructions at the top of the buffer
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, {
            '# Edit commit message then save (:w) to commit',
            "# Lines starting with '#' will be ignored",
            '#',
            '# Press :q to cancel',
        })

        -- Position cursor after the instructions
        vim.api.nvim_win_set_cursor(win, { 5, 0 })
        vim.cmd('startinsert')
    end

    -- Generate commit message with lumen
    run_cmd('lumen draft', {
        name = 'lumen draft',
        on_success = function(output)
            if #output == 0 then
                return log(
                    'lumen draft produced no output',
                    vim.log.levels.ERROR
                )
            end

            local commit_message = output[1]
            log(string.format('generated commit message: %s', commit_message))

            -- Open buffer for editing the message
            edit_commit_message(commit_message)
        end,
        on_error = function(err)
            log(
                string.format('lumen draft failed: %s', err),
                vim.log.levels.ERROR
            )
        end,
    })
end

vim.keymap.set(
    'n',
    '<leader>ga',
    lumen_commit_push,
    { desc = 'AI commit and push (lumen)' }
)
