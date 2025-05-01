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

            -- Commit changes
            run_cmd(
                string.format(
                    'git commit -m %s',
                    vim.fn.shellescape(commit_message)
                ),
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
