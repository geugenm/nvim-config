return {
    {
        "Civitasv/cmake-tools.nvim",
        lazy = true,
        opts = {
            cmake_command = "cmake",
            cmake_regenerate_on_save = true,
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_options = {},
            cmake_virtual_text_support = true,
        },
        keys = {
            {
                "<leader>kg",
                "<cmd>CMakeGenerate<CR>",
                desc = "CMake Generate",
            },
            {
                "<leader>kb",
                "<cmd>CMakeBuild<CR>",
                desc = "CMake Build",
            },
            {
                "<leader>kr",
                "<cmd>CMakeRun<CR>",
                desc = "CMake Run Target",
            },
            {
                "<leader>kd",
                "<cmd>CMakeDebug<CR>",
                desc = "CMake Debug Target",
            },
            {
                "<leader>kse",
                "<cmd>CMakeStopExecutor<CR>",
                desc = "CMake Stop",
            },
            {
                "<leader>ksr",
                "<cmd>CMakeStopRunner<CR>",
                desc = "CMake Stop",
            },
            {
                "<leader>kC",
                "<cmd>CMakeClean<CR>",
                desc = "CMake Clean",
            },
            {
                "<leader>kp",
                "<cmd>CMakeSelectConfigurePreset<CR>",
                desc = "CMake Select Configure Preset",
            },
            {
                "<leader>kP",
                "<cmd>CMakeSelectBuildPreset<CR>",
                desc = "CMake Select Build Preset",
            },
            {
                "<leader>kt",
                "<cmd>CMakeSelectBuildTarget<CR>",
                desc = "CMake Select Build Target",
            },
            {
                "<leader>kl",
                "<cmd>CMakeSelectLaunchTarget<CR>",
                desc = "CMake Select Launch Target",
            },
            {
                "<leader>kk",
                "<cmd>CMakeSelectKit<CR>",
                desc = "CMake Select Kit (No Preset)",
            },
            {
                "<leader>kT",
                "<cmd>CMakeSelectBuildType<CR>",
                desc = "CMake Select Build Type (No Preset)",
            },
        },
    },
}
