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
                "<leader>kc",
                function()
                    require("cmake-tools").configure()
                end,
                desc = "CMake Configure",
            },
            {
                "<leader>kb",
                function()
                    require("cmake-tools").build()
                end,
                desc = "CMake Build",
            },
            {
                "<leader>kr",
                function()
                    require("cmake-tools").run()
                end,
                desc = "CMake Run Target",
            },
            {
                "<leader>kd",
                function()
                    require("cmake-tools").debug()
                end,
                desc = "CMake Debug Target",
            },
            {
                "<leader>ks",
                function()
                    require("cmake-tools").stop()
                end,
                desc = "CMake Stop",
            },
            {
                "<leader>kC",
                function()
                    require("cmake-tools").clean()
                end,
                desc = "CMake Clean",
            },
            {
                "<leader>kp",
                function()
                    require("cmake-tools").select_configure_preset()
                end,
                desc = "CMake Select Configure Preset",
            },
            {
                "<leader>kP",
                function()
                    require("cmake-tools").select_build_preset()
                end,
                desc = "CMake Select Build Preset",
            },
            {
                "<leader>kt",
                function()
                    require("cmake-tools").select_build_target()
                end,
                desc = "CMake Select Build Target",
            },
            {
                "<leader>kl",
                function()
                    require("cmake-tools").select_launch_target()
                end,
                desc = "CMake Select Launch Target",
            },
            {
                "<leader>kk",
                function()
                    require("cmake-tools").select_kit()
                end,
                desc = "CMake Select Kit (No Preset)",
            },
            {
                "<leader>kT",
                function()
                    require("cmake-tools").select_build_type()
                end,
                desc = "CMake Select Build Type (No Preset)",
            },
        },
    },
}
