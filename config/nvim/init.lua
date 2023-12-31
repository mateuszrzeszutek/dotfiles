---- basic options

-- general
vim.opt.autoread = true

vim.opt.whichwrap = "b,s,<,>,h,l"

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ui
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.scrolloff = 5
vim.opt.mouse = "a"

local os = vim.loop.os_uname().sysname
if os == "Darwin" then
  vim.opt.guifont = "Monaco:h14"
elseif os == "Linux" then
  vim.opt.guifont = "DejaVu Sans Mono 14"
end

-- line breaks
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

-- indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- completion
vim.opt.wildmenu = true

vim.opt.wildignore = table.concat({
  "*/.git/*,*/.hg/*,*/.svn/*",
  "*/target/*,*.class,*.jar",
  "*.o,*.so",
  "*.pyc"
}, ',')

-- netrw -- built-in file explorer
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_localcopydircmd = 'cp -r'

---- keys
vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>fe', ':Lexplore<cr>')
vim.keymap.set('n', '<leader>fw', ':w<cr>')

vim.keymap.set('n', '<leader>q', ':q<cr>')

vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>')

-- maybe not needed?
--vim.keymap.set('i', '<c-h>', '<backspace>')
--vim.keymap.set('i', '<c-j>', '<cr>')
--vim.keymap.set('i', '<c-k>', '<c-o>O')
--vim.keymap.set('i', '<c-l>', '<Del>')

-- shifting without leaving selection mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- windows
vim.keymap.set('n', '<c-h>', '<c-W>h')
vim.keymap.set('n', '<c-j>', '<c-W>j')
vim.keymap.set('n', '<c-k>', '<c-W>k')
vim.keymap.set('n', '<c-l>', '<c-W>l')

vim.keymap.set('n', '<c-w>h', ':topleft vnew<cr>')
vim.keymap.set('n', '<c-w>j', ':botright new<cr>')
vim.keymap.set('n', '<c-w>k', ':topleft new<cr>')
vim.keymap.set('n', '<c-w>l', ':botright vnew<cr>')

-- buffers
vim.keymap.set('n', '<tab>', ':BufferLineCycleNext<cr>')
vim.keymap.set('n', '<s-tab>', ':BufferLineCyclePrev<cr>')

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  {'folke/tokyonight.nvim'},
  {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
  {'akinsho/bufferline.nvim'},
  {"lukas-reineke/indent-blankline.nvim"},
  {'m4xshen/autoclose.nvim'},

  -- TODO consider more plugins
  -- - treesitter -- syntax tree parsing, better syntax highlighting
  -- - nvim-tree -- file manager
  -- - Comment.nvim
  -- - telescope -- fuzzy finder
})

-- colorscheme
vim.cmd.colorscheme('tokyonight-night')

-- bottom status line
require('lualine').setup({
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  }
})

-- "tabs" for open buffers
require('bufferline').setup({
  options = {
    numbers = "buffer_id",
    show_buffer_icons = false,
    buffer_close_icon = '✕'
  }
})

-- indent lines
require('ibl').setup()

-- simple autoclose brackets/parens/etc
require('autoclose').setup()

