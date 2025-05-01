-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function lumen_commit_push()
    local function log(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO)
    end

    -- Check if there are staged changes ready to commit
    local function has_staged_changes()
        -- Exit code is non-zero if there are staged changes
        local result = vim.fn.system('git diff --cached --quiet')
        return vim.v.shell_error ~= 0
    end

    -- Prompt to stage changes if needed
    local function prompt_stage_changes()
        vim.ui.select({ 'Yes', 'No' }, {
            prompt = 'No staged changes. Stage all files?',
            format_item = function(item)
                return item == 'Yes' and ' Stage all changes' or ' Cancel'
            end,
        }, function(choice)
            if choice == 'Yes' then
                vim.fn.jobstart('git add -A', {
                    on_exit = function(_, code)
                        if code == 0 then
                            if has_staged_changes() then
                                log('Changes staged successfully')
                                generate_commit_message()
                            else
                                log(
                                    'No changes to commit after staging',
                                    vim.log.levels.WARN
                                )
                            end
                        else
                            log('Failed to stage changes', vim.log.levels.ERROR)
                        end
                    end,
                })
            else
                log('Commit canceled', vim.log.levels.INFO)
            end
        end)
    end

    -- Generate commit message with lumen
    local function generate_commit_message()
        vim.fn.jobstart('lumen draft', {
            stdout_buffered = true,
            on_stdout = function(_, data)
                if not data or #data == 0 or not data[1] or data[1] == '' then
                    return log(
                        'Failed to generate commit message',
                        vim.log.levels.ERROR
                    )
                end
                edit_commit_message(data[1])
            end,
            on_stderr = function(_, err)
                if err and #err > 0 then
                    log(
                        'Lumen error: ' .. table.concat(err, '\n'),
                        vim.log.levels.ERROR
                    )
                end
            end,
            on_exit = function(_, code)
                if code ~= 0 then
                    log(
                        'Lumen draft failed with code: ' .. code,
                        vim.log.levels.ERROR
                    )
                end
            end,
        })
    end

    -- Edit and confirm commit message
    local function edit_commit_message(message)
        vim.ui.input({
            prompt = 'Edit commit message:',
            default = message,
            filetype = 'gitcommit',
            border = 'rounded',
            title = ' Lumen Commit ',
            title_pos = 'center',
        }, function(final_msg)
            if not final_msg or final_msg:gsub('%s', '') == '' then
                return log('Commit aborted: empty message', vim.log.levels.WARN)
            end

            vim.fn.jobstart('git commit -m ' .. vim.fn.shellescape(final_msg), {
                on_exit = function(_, code)
                    if code == 0 then
                        log(' Commit successful')
                        push_changes()
                    else
                        log(
                            ' Commit failed (code ' .. code .. ')',
                            vim.log.levels.ERROR
                        )
                    end
                end,
            })
        end)
    end

    -- Push changes after successful commit
    local function push_changes()
        vim.fn.jobstart('git push', {
            on_exit = function(_, code)
                log(
                    code == 0 and ' Push successful'
                        or ' Push failed (code ' .. code .. ')',
                    code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
                )
            end,
        })
    end

    -- Start the workflow by checking for staged changes
    if has_staged_changes() then
        generate_commit_message()
    else
        prompt_stage_changes()
    end
end

vim.keymap.set(
    'n',
    '<leader>ga',
    lumen_commit_push,
    { desc = 'AI commit and push (lumen)' }
)
