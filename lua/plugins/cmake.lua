return {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'cmakelint', -- Linting for CMake files
                'gersemi', -- CMake formatter
                'neocmakelsp', -- Advanced CMake language server
            },
        },
    },
    {
        'Civitasv/cmake-tools.nvim',
        lazy = true,
        opts = {
            cmake_regenerate_on_save = true,
            cmake_use_preset = true,
            cmake_soft_link_compile_commands = true,
            cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
            cmake_notifications = {
                runner = { enabled = true },
                executor = { enabled = true },
                spinner = {
                    '⠋',
                    '⠙',
                    '⠹',
                    '⠸',
                    '⠼',
                    '⠴',
                    '⠦',
                    '⠧',
                    '⠇',
                    '⠏',
                }, -- icons used for progress display
                refresh_rate_ms = 100, -- how often to iterate icons
            },
            cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
        },
        keys = {
            {
                '<leader>kg',
                '<cmd>CMakeGenerate<CR>',
                desc = 'CMake Generate',
            },
            {
                '<leader>kb',
                '<cmd>CMakeBuild<CR>',
                desc = 'CMake Build',
            },
            {
                '<leader>kr',
                '<cmd>CMakeRun<CR>',
                desc = 'CMake Run Target',
            },
            {
                '<leader>kd',
                '<cmd>CMakeDebug<CR>',
                desc = 'CMake Debug Target',
            },
            {
                '<leader>kse',
                '<cmd>CMakeStopExecutor<CR>',
                desc = 'CMake Stop Executor',
            },
            {
                '<leader>ksr',
                '<cmd>CMakeStopRunner<CR>',
                desc = 'CMake Stop Runner',
            },
            {
                '<leader>kC',
                '<cmd>CMakeClean<CR>',
                desc = 'CMake Clean',
            },
            {
                '<leader>kp',
                '<cmd>CMakeSelectConfigurePreset<CR>',
                desc = 'CMake Select Configure Preset',
            },
            {
                '<leader>kP',
                '<cmd>CMakeSelectBuildPreset<CR>',
                desc = 'CMake Select Build Preset',
            },
            {
                '<leader>kt',
                '<cmd>CMakeSelectBuildTarget<CR>',
                desc = 'CMake Select Build Target',
            },
            {
                '<leader>kl',
                '<cmd>CMakeSelectLaunchTarget<CR>',
                desc = 'CMake Select Launch Target',
            },
            {
                '<leader>kk',
                '<cmd>CMakeSelectKit<CR>',
                desc = 'CMake Select Kit (No Preset)',
            },
            {
                '<leader>kT',
                '<cmd>CMakeSelectBuildType<CR>',
                desc = 'CMake Select Build Type (No Preset)',
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        optional = true,
        lazy = true,
        opts = function(_, opts)
            local cmake = require('cmake-tools')

            table.insert(opts.sections.lualine_c or {}, {
                function()
                    if not cmake.is_cmake_project() then
                        return ''
                    end

                    local parts = {}

                    -- Add preset info with explicit label
                    if cmake.has_cmake_preset() then
                        local preset = cmake.get_configure_preset()
                        if preset and preset ~= '' then
                            table.insert(
                                parts,
                                string.format('preset:%s', preset)
                            )
                        end
                    end

                    -- Add build type with explicit label
                    local build_type = cmake.get_build_type()
                    if build_type and build_type ~= '' then
                        table.insert(
                            parts,
                            string.format('type:%s', build_type)
                        )
                    end

                    -- Add target with explicit label
                    local target = cmake.get_build_target()
                    if target and target ~= '' then
                        table.insert(
                            parts,
                            string.format('build_target:%s', target)
                        )
                    end

                    -- Format with Boost-style explicit naming and consistent separators
                    if #parts > 0 then
                        return string.format(
                            ' cmake[%s]',
                            table.concat(parts, ' | ')
                        )
                    else
                        return ' cmake[unconfigured]'
                    end
                end,
                cond = function()
                    return package.loaded['cmake-tools'] ~= nil
                end,
                color = { fg = '#1e90ff' },
            })
        end,
    },
}
