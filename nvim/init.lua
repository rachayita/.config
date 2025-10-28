-------------------------------------------------------------------------------
-- leader first
-------------------------------------------------------------------------------
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-------------------------------------------------------------------------------
-- globals + miscellaneous
-------------------------------------------------------------------------------
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
-- on os
vim.g.python3_host_prog = 'python3'
vim.g.python_host_prog = 'python'
vim.g.perl_host_prog = 'perl'
vim.g.loaded_perl_provider = 0
-- rust debugger: gdb installation required
vim.g.termdebugger = "rust-gdb"
vim.g.termdebug_wide = 1

-------------------------------------------------------------------------------
-- vim.opt
-------------------------------------------------------------------------------
vim.opt.cmdheight = 0  -- hide command panel
vim.opt.mouse = ''
vim.opt.termguicolors = true
vim.opt.cursorline = false
vim.opt.path:append('**') -- tab completion for all file related task
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.wrap = false
vim.opt.linebreak = false
vim.opt.showmode = false
vim.opt.signcolumn = 'yes' -- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true -- infinite undo! NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.colorcolumn = '90'
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.completeopt = { "menuone" }
vim.opt.shortmess:append "casI"
vim.opt.rtp:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
vim.opt.belloff:append('ctrlg')
vim.opt.lazyredraw = true -- faster scrolling, may cause screen problem
vim.opt.smartindent = true
vim.opt.ignorecase = true -- case-insensitive search/replace
vim.opt.smartcase = true -- unless uppercase in search term
vim.opt.vb = true -- never ever make my terminal beep
vim.opt.wildmode = 'list:longest' -- wildmenu completion: list all but only complete longest  match
vim.opt.diffopt:append('iwhite') -- by ignoring whitespacel in diffs (nvim -d)
vim.opt.diffopt:append('algorithm:histogram') -- using a smarter algorithm in nvim-d
vim.opt.diffopt:append('indent-heuristic')
vim.opt.diffopt:append('context:0') -- identical lines kept above-below, default 6
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•' -- show hidden chars, show tabs nicer
vim.opt.wildignore =
'.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,**/node_modules/**' -- in :e suggestion

-------------------------------------------------------------------------------
-- hotkeys
-------------------------------------------------------------------------------
vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd>nohlsearch<cr>') -- Ctrl+c to stop searching
vim.keymap.set('n', '<leader>n', '<cmd>DiffviewOpen<cr>')
vim.keymap.set('n', '<leader>N', '<cmd>DiffviewClose<cr>')
vim.keymap.set('n', '<leader>S', '<cmd>set ls=2<cr>') -- show status line
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<cr>')
vim.keymap.set('n', '<leader>c', ':e $MYVIMRC<CR>')
vim.keymap.set('n', 'f', '<C-f>') -- page down/up
vim.keymap.set('n', 'F', '<C-b>') -- page up
vim.keymap.set('n', '<leader><cr>', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>wq<cr>')
vim.keymap.set({ 'n', 'v' }, 'qq', '<cmd>q!<cr>')
vim.keymap.set('n', '<C-q>', '<cmd>qall<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>bd!<cr>')
vim.keymap.set('', '<C-p>', '<cmd>files<cr>') -- quick-open
vim.keymap.set('n', ';', ':')                 -- make missing : less annoying
vim.keymap.set('', 'H', '^')                  -- jump to start
vim.keymap.set('', 'L', '$')                  -- jump to end
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set('n', '<leader><leader>', '<c-^>')     -- toggles between buffers
vim.keymap.set('n', '<leader>,', ':set invlist<cr>') -- shows/hides hidden characters
vim.keymap.set('n', '<leader>m', 'ct_')              -- replacing up to next _ (like in variable names)
vim.keymap.set('', '<F1>', ':help ')
vim.keymap.set('i', '<F1>', ':help ')
vim.keymap.set('n', '<leader>t', ':terminal<cr>')
vim.keymap.set('n', '<leader>0', ':w !sudo tee %<cr>') -- save root file
vim.keymap.set('n', 'q:', ':q`]')
vim.keymap.set('n', 'q', '<ESC>')
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>') -- open file adjacent to current
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':bn<cr>')
vim.keymap.set('n', '<right>', ':bp<cr>')
-- make j and k move by visual line, not actual line, when text is soft-wrapped
--vim.keymap.set('n', 'j', 'gj')
--vim.keymap.set('n', 'k', 'gk')
-- automatically jump to end of text you pasted, paste multiple lines multiple times with simple ppppp
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'n', 'v' }, 'p', 'p`]')
vim.keymap.set('n', 'gV', '`[v`]') -- quickly select text you just pasted
-- format para to 80 chars (selected or not)
vim.keymap.set('n', '<leader>g', 'gqap')
vim.keymap.set('x', '<leader>g', 'gqa')
vim.keymap.set('n', '<leader>b', ":packadd termdebug<cr> :Termdebug<cr>")
-- navigating window frames
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<C-w>l')
vim.keymap.set({ 'n', 'v' }, '<C-up>', '<C-w>+')
vim.keymap.set({ 'n', 'v' }, '<C-down>', '<C-w>-')
vim.keymap.set({ 'n', 'v' }, '<C-left>', '<C-w><')
vim.keymap.set({ 'n', 'v' }, '<C-right>', '<C-w>>')

-------------------------------------------------------------------------------
-- floating window
-------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000", fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#ffffff", fg = "#ff0000" })
vim.api.nvim_set_hl(0, "FloatFooter", { bg = "#ffffff", fg = "#ff0000" })
vim.o.winborder = 'rounded'

-------------------------------------------------------------------------------
-- disable built-in plugins
-------------------------------------------------------------------------------
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-------------------------------------------------------------------------------
-- autocommands
-------------------------------------------------------------------------------
-- Terminal settings
-- Open a Terminal on the right tab
vim.api.nvim_create_autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})
-- Remove whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})
-- highlight yanked text
vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    pattern = '*',
    command = 'silent! lua vim.hl.on_yank({ timeout = 500 })'
  }
)

-- remove status line
vim.api.nvim_create_autocmd( 'BufReadPre', { pattern = '*', command = ":set laststatus=0"})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
  'BufReadPost',
  {
    pattern = '*',
    callback = function()
      if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        -- except for in git commit messages
        -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
        if not vim.fn.expand('%:p'):find('.git', 1, true) then
          vim.cmd('exe "normal! g\'\\""')
        end
      end
    end
  }
)
-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
-- help filetype detection (add as needed)
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.md', command = 'set filetype=markdown' })
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })

-------------------------------------------------------------------------------
-- lazy.vim plugin manager
-------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    --
    -- nanotee/zoxide.vim
    { 'nanotee/zoxide.vim' },
    --folke/which-key.nvim
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    -- folke/persistence.nvim
    {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      opts = {
        -- add any custom options here
      },
      -- load the session for the current directory
      vim.keymap.set("n", "<leader>ls", function() require("persistence").load() end),
      -- select a session to load
      vim.keymap.set("n", "<leader>l", function() require("persistence").select() end),
      -- load the last session
      vim.keymap.set("n", "<leader>ll", function() require("persistence").load({ last = true }) end),
      -- stop Persistence => session won't be saved on exit
      vim.keymap.set("n", "<leader>ld", function() require("persistence").stop() end),
    },
    -- hedyhli/outline.nvim
    {
      "hedyhli/outline.nvim",
      lazy = true,
      cmd = { "Outline", "OutlineOpen" },
      keys = { -- Example mapping to toggle outline
        { "<leader>-", "<cmd>Outline<CR>", desc = "Toggle outline" },
      },
      opts = {
        -- Your setup opts here
      },
    },
    -- "nvim-tree/nvim-tree.lua"
    {
      "nvim-tree/nvim-tree.lua",
      config = function()
        require("nvim-tree").setup()
      end,
      vim.keymap.set('n', "<leader>s", "<cmd>NvimTreeFindFileToggle<cr>"),
    },
    -- akinsho/git-conflict.nvim
    { 'akinsho/git-conflict.nvim', version = "*", config = true },
    -- 'sindrets/diffview.nvim'
    { "sindrets/diffview.nvim" },
    -- auto-cd to root of git project
    -- 'airblade/vim-rooter'
    {
      'notjedi/nvim-rooter.lua',
      config = function()
        require('nvim-rooter').setup()
      end
    },
    -- romgrk/barbar.nvim
    {
      'romgrk/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
      },
      opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        insert_at_start = false,
        auto_hide = 1,
        icons = { current = { filetype = { enabled = true } }, buffer_index = 'subscript', buffer_number = 'superscript', diagnostics = { enabled = true } },
        --maximum_padding = math.huge,
        -- …etc.
      },
      version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    -- vim-expand-region
    {
      "terryma/vim-expand-region",
      vim.keymap.set('v', 'v', '<Plug>(expand_region_expand)'),
      vim.keymap.set('v', '<C-v>', '<Plug>(expand_region_shrink)'),
    },
    -- nvim-colorizer #558817
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require('colorizer').setup()
      end
    },
    -- nvim-treesitter/nvim-treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      config = function()
        require 'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all" (the listed parsers MUST always be installed)
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust" },

          markdown = {
            enable = true,
            -- user configuration goes here
            inline_surround = { --[[ ... ]] },
            --on_attach = function(bufnr) --[[ ... ]] end,
          },
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          -- List of parsers to ignore installing (or "all")
          ignore_install = { "javascript" },

          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

          highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
        }
      end
    },
    -- 'mfussenegger/nvim-dap'
    {
      'mfussenegger/nvim-dap',
      dependencies = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
      config = function()
        local dap = require("dap")
        dap.adapters["rust-gdb"] = {
          type = "executable",
          command = "rust-gdb",
          args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.rust = {
          {
            name = "Launch",
            type = "rust-gdb",
            request = "launch",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            args = {}, -- provide arguments if needed
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
          },
          {
            name = "Select and attach to process",
            type = "rust-gdb",
            request = "attach",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
              local name = vim.fn.input('Executable name (filter): ')
              return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = "${workspaceFolder}"
          },
          {
            name = "Attach to gdbserver :1234",
            type = "rust-gdb",
            request = "attach",
            target = "localhost:1234",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
          }
        }
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end,
      vim.keymap.set('n', '<F4>', '<cmd>DapToggleBreakpoint<cr>'),
      vim.keymap.set('n', '<F5>', '<cmd>DapContinue<cr>'),
      vim.keymap.set('n', '<F6>', '<cmd>DapStepInto<cr>'),
      vim.keymap.set('n', '<F7>', '<cmd>DapStepOver<cr>'),
      vim.keymap.set('n', '<F8>', '<cmd>DapStepOut<cr>'),
      vim.keymap.set('n', '<F9>', '<cmd>DapTerminate<cr>'),
      vim.keymap.set('n', '<F10>', '<cmd>DapClearBreakpoints<cr>'),
      vim.keymap.set('n', '<leader>u', "<cmd>lua require('dapui').toggle()<cr>"),
    },
    -- j--c/cwd.nvim
    {
      "j--c/cwd.nvim",
      config = function()
        require('cwd').setup()
      end,
      vim.keymap.set('n', '<leader>/', '<cmd>CwdChange<cr>')
    },
    -- lualine status line
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require('lualine').setup {
          options = { theme = 'codedark' }
        }
      end
    },
    -- tpope/vim-fugitive
    { "tpope/vim-fugitive" },
    -- tabular
    {
      "godlygeek/tabular",
      vim.keymap.set('n', '<leader>T', ':Tabularize /')
    },
    --  gitsign.nvim
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '-' },
          topdelete = { text = '^' },
          changedelete = { text = '*' },
        },
      },
    },
    --nvim-mini/mini.nvim
    {
      'nvim-mini/mini.nvim',
      version = '*',
      config = function()
        require('mini.pairs').setup()
      end
    },
    -- inline function signatures
    {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      opts = {
        -- cfg options
      },
    },
    -- language support
    -- toml
    {
      'cespare/vim-toml',
      ft = { "toml" },
    },
    -- rust
    {
      'rust-lang/rust.vim',
      ft = { "rust" },
      config = function()
        vim.g.rustfmt_autosave = 1
        vim.g.rustfmt_emit_files = 1
        vim.g.rustfmt_fail_silently = 0
        vim.g.rust_clip_command = 'xclip -selection clipboard'
      end
    },
    -- vimwiki/vimwiki
    {
      "vimwiki/vimwiki",
      init = function()
        vim.g.vimwiki_list = {
          {
            path = '~/Documents/vimwiki',
            syntax = 'markdown',
            ext = '.md',
          },
        }
      end,
    },
    --'MeanderingProgrammer/render-markdown.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      opts = {},
      vim.treesitter.language.register('markdown', 'vimwiki'),
      config = function()
        require('render-markdown').setup({
          completions = { blink = { enabled = true } },
          file_types = { 'markdown', 'vimwiki' },
        })
      end
    },
    -- "AbdelrahmanDwedar/awesome-nvim-colorschemes",
    {
      "AbdelrahmanDwedar/awesome-nvim-colorschemes",
      config = function()
        require('tokyonight').setup({
          lazy = false,
          style = "night",
          transparent = true,
          terminal_colors = true,
          styles = {
            sidebars = "transparent", -- style for sidebars, see below
            floats = "transparent",
          }
        })
      end,
    },
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    --
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      -- @type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-s: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          preset = 'default',
          ['<Tab>'] = { 'select_and_accept' },
        },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = false } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    -- ibhagwan/fzf-lua
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {},
      vim.keymap.set({ "n", "v", "i" }, "<leader>z", ":lua require('fzf-lua').files()<cr>"),
      vim.keymap.set('n', '<leader>x', ':FzfLua<cr>'),
    },
    -- vifm / neovim-vifm
    {
      'vifm/vifm.vim',
      vim.keymap.set('n', '<leader>v', '<cmd>Vifm<cr>') },
    -- LSP
    {
      'neovim/nvim-lspconfig',
      config = function()
        -- Setup language servers.

        -- Rust
        vim.lsp.config('rust_analyzer', {
          -- Server-specific settings. See `:help lspconfig-setup`
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all",
              },
              checkOnSave = {
                enable = true,
              },
              check = {
                command = "clippy",
              },
              imports = {
                group = {
                  enable = true,
                },
              },
              completion = {
                postfix = {
                  enable = true,
                },
              },
            },
          },
        })
        vim.lsp.enable('rust_analyzer')

        -- Bash LSP
        if vim.fn.executable('bash-language-server') == 1 then
          vim.lsp.enable('bashls')
        end

        -- toml
        if vim.fn.executable('taplo') == 1 then
          vim.lsp.enable('taplo')
          vim.lsp.config(("taplo"), {
            settings = {
              Toml = {
                root_makers = { ".taplo.toml", "taplo.toml", ".git", "Cargo.toml" }
              }
            }
          })
        end

        -- lua-language-server for lua
        if vim.fn.executable('lua-language-server') == 1 then
          vim.lsp.enable('lua_ls')
          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "bufnr" } -- recognize 'vim' as global variable
                }
              }
            }
          })
        end

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>9', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)

            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            -- TODO: find some way to make this only apply to the current line.
            if client.server_capabilities.inlayHintProvider ~= nil then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end

            -- None of this semantics tokens business.
            -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
            -- client.server_capabilities.semanticTokensProvider = nil
          end,
        })
      end
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "wildcharm" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.cmd [[colorscheme tokyonight-night]]

--[[
-------------------------------------------------------------------------------

-- Notes:

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- nvimdiff or nvim -d
-------------------------------------------------------------------------------
- ]c          - next difference
- [c          - previous difference
- do          - diff obtain
- dp          - diff put
- zo          - open folded text
- zc          - close folded text
- zR          - unfold all lines
- zr          - open all folds
- zm          - close all folds
- :diffoff!   - to end diff mode
    :syn off     - to remove colors
- :diffupdate - to remove leftover spacing issues)
- :only       - once you’re done reviewing all conflicts, this shows only the middle/merged file
- :windo diffthis - to begin diffing on all visible windows which executes :diffthis on each window.
- default identifiers that can be selected using diffget
  - LO local master copy
  - RE remote master to be merged
  - BA common ancestor of remote and local changes.
- :diffupdate - re-scan the files for differences
  - choose which version you want to keep with :diffget //2 or :diffget //3
  - //2 and //3 are unique identifiers for target/master copy and merge/branch copy file names
- If you were trying to do a git pull when you ran into merge conflicts:
  - type `git rebase –continue`

-------------------------------------------------------------------------------
-- search & replace
-------------------------------------------------------------------------------
- `:5,17s/^/#/ comment line 5-17
- `:%s/^/#/` comment all lines
- `gx` opens links under cursor
- `%s/find/replace/gci`
    %: Indicates the entire file
    s: Stands for substitute
    g: Replaces all occurrences in each line
    i: Case insensitive
    c: Confirm each replacement

]]
