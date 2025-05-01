-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function lumen_commit_push()
    local function log(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO)
    end

    local function run_cmd(cmd, opts)
        vim.fn.jobstart(cmd, {
            stdout_buffered = true,
            on_stdout = opts.on_stdout,
            on_stderr = opts.on_stderr,
            on_exit = function(_, code)
                if code == 0 and opts.on_success then
                    opts.on_success()
                elseif opts.on_error then
                    opts.on_error(code)
                end
            end,
        })
    end

    run_cmd('lumen draft', {
        on_stdout = function(_, data)
            if not data or #data == 0 then
                return
            end

            local commit_message = table.concat(data, '\n')
            local buf = vim.api.nvim_create_buf(true, true)

            vim.api.nvim_buf_set_lines(
                buf,
                0,
                -1,
                false,
                vim.split(commit_message, '\n')
            )
            vim.api.nvim_open_win(buf, true, {
                relative = 'cursor',
                width = 72,
                height = 5,
                style = 'minimal',
                border = 'single',
                title = ' Edit Commit Message ',
                title_pos = 'center',
            })

            vim.api.nvim_create_autocmd('BufWritePost', {
                buffer = buf,
                once = true,
                callback = function()
                    local final_msg = table.concat(
                        vim.api.nvim_buf_get_lines(buf, 0, -1, false),
                        '\n'
                    )
                    run_cmd('git commit -m ' .. vim.fn.shellescape(final_msg), {
                        on_success = function()
                            run_cmd('git push', {
                                on_success = function()
                                    log('push successful')
                                end,
                                on_error = function(c)
                                    log(
                                        'push failed: ' .. c,
                                        vim.log.levels.ERROR
                                    )
                                end,
                            })
                        end,
                        on_error = function(c)
                            log('commit failed: ' .. c, vim.log.levels.ERROR)
                        end,
                    })
                end,
            })
        end,
        on_stderr = function(_, data)
            log(
                'lumen error: ' .. table.concat(data, '\n'),
                vim.log.levels.ERROR
            )
        end,
        on_error = function(c)
            log('lumen failed: ' .. c, vim.log.levels.ERROR)
        end,
    })
end

vim.keymap.set(
    'n',
    '<leader>ga',
    lumen_commit_push,
    { desc = 'AI commit and push (lumen)' }
)
