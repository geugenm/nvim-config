-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function lumen_commit_push()
    -- Constants (Boost style naming)
    local exit_code_success = 0
    local defer_delay_ms = 100
    local icon_stage = ''
    local icon_cancel = ''
    local icon_push = ''
    local icon_warning = ''
    local icon_commit = '' -- Using a checkmark for commit

    local choice_yes = 'Yes'
    local choice_no = 'No'
    local choice_commit_only = 'Commit only'
    local choice_commit_and_push = 'Commit and push'

    local function log(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO)
    end

    local function git_staged_check()
        -- system() returns exit code in v:shell_error
        vim.fn.system('git diff --cached --quiet')
        -- Non-zero means changes are staged
        return vim.v.shell_error ~= exit_code_success
    end

    local function stage_files(callback)
        vim.ui.select({ choice_yes, choice_no }, {
            prompt = 'No staged changes. Stage all files?',
            format_item = function(item)
                if item == choice_yes then
                    return string.format('%s Stage all changes', icon_stage)
                else
                    return string.format('%s Cancel', icon_cancel)
                end
            end,
        }, function(choice)
            if choice == choice_yes then
                vim.fn.jobstart('git add -A', {
                    on_exit = function(_, code)
                        if code == exit_code_success then
                            if git_staged_check() then
                                log('Changes staged successfully')
                                callback() -- Proceed after successful staging
                            else
                                log(
                                    'No changes to commit after staging',
                                    vim.log.levels.WARN
                                )
                            end
                        else
                            log(
                                'Failed to stage changes (code ' .. code .. ')',
                                vim.log.levels.ERROR
                            )
                        end
                    end,
                })
            else
                log('Operation canceled', vim.log.levels.INFO)
            end
        end)
    end

    local function push_changes()
        vim.fn.jobstart('git push', {
            on_exit = function(_, code)
                local status_icon = (code == exit_code_success) and icon_push
                    or icon_warning
                local message = (code == exit_code_success)
                        and 'Push successful'
                    or 'Push failed (code ' .. code .. ')'
                local level = (code == exit_code_success)
                        and vim.log.levels.INFO
                    or vim.log.levels.ERROR
                log(string.format('%s %s', status_icon, message), level)
            end,
        })
    end

    local function commit_changes(message, should_push)
        vim.fn.jobstart('git commit -m ' .. vim.fn.shellescape(message), {
            on_exit = function(_, code)
                if code == exit_code_success then
                    log(
                        string.format('%s Commit successful', icon_commit),
                        vim.log.levels.INFO
                    )
                    if should_push then
                        push_changes()
                    end
                else
                    log(
                        string.format(
                            '%s Commit failed (code %d)',
                            icon_warning,
                            code
                        ),
                        vim.log.levels.ERROR
                    )
                end
            end,
        })
    end

    local function edit_commit_message(message)
        vim.ui.input({
            prompt = 'Edit commit message:',
            default = message,
            filetype = 'gitcommit',
            border = 'rounded',
            title = 'Lumen Commit',
            title_pos = 'center',
        }, function(final_msg)
            if not final_msg or final_msg:gsub('%s', '') == '' then
                return log(
                    string.format(
                        '%s Commit aborted: empty message',
                        icon_warning
                    ),
                    vim.log.levels.WARN
                )
            end

            -- Ask user whether to commit only or commit and push
            vim.ui.select({ choice_commit_only, choice_commit_and_push }, {
                prompt = 'Choose action:',
                format_item = function(item)
                    if item == choice_commit_only then
                        return string.format('%s Commit only', icon_commit)
                    else
                        return string.format('%s Commit and push', icon_push) -- Use push icon here maybe?
                    end
                end,
            }, function(choice)
                if choice == choice_commit_only then
                    commit_changes(final_msg, false)
                elseif choice == choice_commit_and_push then
                    commit_changes(final_msg, true)
                else
                    log(
                        string.format('%s Operation canceled', icon_cancel),
                        vim.log.levels.INFO
                    )
                end
            end)
        end)
    end

    -- Main workflow execution starts here
    if not git_staged_check() then
        -- No staged changes, prompt user to stage them.
        -- The callback will re-initiate the process if staging is successful.
        return stage_files(function()
            -- Need to wait a moment for git index to update reliably?
            vim.defer_fn(lumen_commit_push, defer_delay_ms)
        end)
    end

    log('Generating commit message with lumen...')
    vim.fn.jobstart('lumen draft', {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if
                not data
                or #data == 0
                or not data[1]
                or data[1]:match('^%s*$')
            then
                return log(
                    string.format(
                        '%s Failed to generate commit message or message is empty',
                        icon_warning
                    ),
                    vim.log.levels.ERROR
                )
            end
            edit_commit_message(data[1])
        end,
        on_stderr = function(_, err)
            if err and #err > 0 and err[1] ~= '' then
                log(
                    'Lumen error: "' .. table.concat(err, '\n') .. '"',
                    vim.log.levels.ERROR
                )
            end
        end,
        on_exit = function(_, code)
            if code ~= exit_code_success then
                log(
                    string.format(
                        '%s Lumen draft process exited with code %d',
                        icon_warning,
                        code
                    ),
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
