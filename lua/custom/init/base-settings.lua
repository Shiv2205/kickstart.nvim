-- ============================================================
-- SECTION 1: FOUNDATION
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
--

do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal

  -- [[ Setting options ]]
  --  See `:help vim.o`
  --  NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

                                                          -- NOTE:
  vim.o.number = true                                     -- Make line numbers default
  vim.o.relativenumber = true                             -- Relative Line numbers
  vim.o.mouse = 'a'                                       -- Enable mouse mode, can be useful for resizing splits for example!
  vim.opt.termguicolors = true
  vim.o.showmode = false                                  -- Don't show the mode, since it's already in the status line
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)  -- See `:help 'clipboard'`
  vim.o.breakindent = true                                -- Enable break indent
  vim.o.undofile = true                                   -- Enable undo/redo changes even after closing and reopening a file
  vim.o.ignorecase = true                                 -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.smartcase = true                                  -- NOTE:
  vim.o.signcolumn = 'yes'                                -- Keep signcolumn on by default
  vim.o.updatetime = 250                                  -- Decrease update time
  vim.o.timeoutlen = 300                                  -- Decrease mapped sequence wait time
  vim.o.splitright = true                                 -- Configure how new splits should be opened
  vim.o.splitbelow = true
  vim.o.list = true
  vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣'
  }
                                                          -- NOTE:
  vim.o.tabstop = 4                                       -- 1 tab = 4 spaces visual
  vim.o.shiftwidth = 4                                    -- 1 tab = 4 spaces indentation
  vim.o.expandtab = true                                  -- Use Spaces instead of tabs

                                                          -- NOTE:
  vim.o.inccommand = 'split'                              -- Preview substitutions live, as you type!
  vim.o.cursorline = true                                 -- Show which line your cursor is on
  vim.o.scrolloff = 10                                    -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.confirm = true                                    -- See `:help 'confirm'`


                                                          -- NOTE: [[ Basic Keymaps ]]
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')     --  See `:help vim.keymap.set()`
  vim.keymap.set('n', '<A-q>', '<cmd>wq<CR>')
  vim.keymap.set('n', 'x', 'V')
  vim.keymap.set('v', 'x', 'j')
  vim.keymap.set('i', 'jk', '<Esc>')
  vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>')
  vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>')

                                                          -- NOTE: Diagnostic Config & Keymaps
  vim.diagnostic.config {                                 --  See `:help vim.diagnostic.Opts`

    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = {
      severity = { min = vim.diagnostic.severity.WARN }
    },

                                                          -- NOTE:
    virtual_text = true,                                  -- Text shows up at the end of the line
    virtual_lines = false,                                -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- NOTE: Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end
