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
}
