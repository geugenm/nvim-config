return {
    {
        'williamboman/mason.nvim',
        opts = {
            ensure_installed = {
                'cpptools', -- Microsoft C++ tools
                'cpplint', -- Google's C++ linter
                'clang-format', -- C++ formatter
                'clangd', -- C++ language server
                'codelldb', -- LLDB-based debugger
                'sonarlint-language-server', -- Static code analyzer
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                clangd = {
                    cmd = {
                        'clangd',
                        '--background-index',
                        '--clang-tidy',
                        '--header-insertion=iwyu',
                        '--completion-style=detailed',
                        '--function-arg-placeholders',
                        '--fallback-style=llvm',
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            if not opts.ensure_installed then
                opts.ensure_installed = {}
            end
            opts.ensure_installed =
                vim.list_extend(opts.ensure_installed, { 'cpp', 'c' })
        end,
    },
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = {
            formatters_by_ft = {
                cpp = { 'clang-format' },
                c = { 'clang-format' },
            },
            formatters = {
                clang_format = {
                    prepend_args = { '-style=file:.clang-format' },
                },
            },
        },
    },
    {
        'mfussenegger/nvim-dap',
        optional = true,
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, 'codelldb')

            opts.handlers = opts.handlers or {}
            opts.handlers.codelldb = function()
                local dap = require('dap')

                -- Setup adapter for codelldb
                dap.adapters.codelldb = {
                    type = 'server',
                    port = '${port}',
                    executable = {
                        command = vim.fn.exepath('codelldb'),
                        args = { '--port', '${port}' },
                    },
                }

                -- Platform detection
                local is_windows = vim.fn.has('win32') == 1
                local is_mac = vim.fn.has('macunix') == 1

                -- Environment variables for optimal debugging
                local debug_env = {
                    -- Enable LLDB to use native PDB reader (Windows)
                    LLDB_USE_NATIVE_PDB_READER = '1',
                }

                -- Add platform-specific environment variables
                if is_windows then
                    -- Windows-specific settings
                    debug_env.LLDB_CONSOLE_ECHO = '1' -- Echo console output
                elseif is_mac then
                    -- macOS-specific settings
                    local llvm_path = '/usr/local/opt/llvm/bin'
                    if vim.fn.isdirectory(llvm_path) == 1 then
                        debug_env.LLVM_SYMBOLIZER_PATH = llvm_path
                            .. '/llvm-symbolizer'
                    end
                else
                    -- Linux-specific settings
                    debug_env.LC_ALL = 'C' -- Use standard locale for consistent output
                end

                -- C++ debug configurations
                dap.configurations.cpp = {
                    {
                        name = 'Launch C++ (CodeLLDB)',
                        type = 'codelldb',
                        request = 'launch',
                        cwd = '${workspaceFolder}',
                        stopOnEntry = false,
                        program = function()
                            return vim.fn.input(
                                'Path to executable: ',
                                vim.fn.getcwd() .. '/',
                                'file'
                            )
                        end,
                        args = {},
                        runInTerminal = false,
                        env = debug_env,
                        initCommands = {
                            'settings set target.process.thread.step-avoid-regexp ""', -- Disable step-avoid
                            'settings set target.input-path /dev/null', -- Avoid hanging
                        },
                    },
                    {
                        name = 'Attach to process',
                        type = 'codelldb',
                        request = 'attach',
                        pid = require('dap.utils').pick_process,
                        args = {},
                        env = debug_env,
                        initCommands = {
                            'settings set target.process.thread.step-avoid-regexp ""',
                        },
                    },
                }

                -- Copy configurations to C as well
                dap.configurations.c = dap.configurations.cpp
            end
        end,
    },
}
