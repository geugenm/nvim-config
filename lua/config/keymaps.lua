-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function lumen_commit_push()
    -- Run lumen draft to generate commit message and capture the output
    vim.fn.jobstart('lumen draft', {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data and #data > 0 and data[1] ~= '' then
                local commit_message = data[1]

                -- Log the generated commit message
                vim.notify(
                    'lumen generated commit message: '
                        .. vim.fn.shellescape(commit_message),
                    vim.log.levels.INFO
                )

                -- Execute git commit with the generated message
                local commit_cmd = 'git commit -m '
                    .. vim.fn.shellescape(commit_message)
                vim.fn.jobstart(commit_cmd, {
                    on_exit = function(_, exit_code)
                        if exit_code == 0 then
                            vim.notify('commit successful', vim.log.levels.INFO)

                            -- Push the changes
                            vim.fn.jobstart('git push', {
                                on_exit = function(_, push_exit_code)
                                    if push_exit_code == 0 then
                                        vim.notify(
                                            'push successful',
                                            vim.log.levels.INFO
                                        )
                                    else
                                        vim.notify(
                                            'push failed with code: '
                                                .. push_exit_code,
                                            vim.log.levels.ERROR
                                        )
                                    end
                                end,
                            })
                        else
                            vim.notify(
                                'commit failed with code: ' .. exit_code,
                                vim.log.levels.ERROR
                            )
                        end
                    end,
                })
            else
                vim.notify(
                    'failed to generate commit message',
                    vim.log.levels.ERROR
                )
            end
        end,
        on_stderr = function(_, data)
            if data and #data > 0 and data[1] ~= '' then
                vim.notify(
                    'lumen error: ' .. table.concat(data, '\n'),
                    vim.log.levels.ERROR
                )
            end
        end,
    })
end

vim.keymap.set(
    'n',
    '<leader>ga',
    lumen_commit_push,
    { desc = 'AI commit and push (lumen)' }
)
