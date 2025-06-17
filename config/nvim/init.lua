-- plugin manager
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
  -- appearance
  {'folke/tokyonight.nvim'},
  {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
  {'akinsho/bufferline.nvim'},
  {"lukas-reineke/indent-blankline.nvim"},

  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'windwp/nvim-autopairs'},

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
    },
  },
  { "nvim-telescope/telescope-file-browser.nvim" },

  -- LSP support
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},

  -- completion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  -- snippets -- required for cmp
  {'hrsh7th/vim-vsnip'},
  {'hrsh7th/cmp-vsnip'},
})

-- general
vim.opt.autoread = true

vim.opt.whichwrap = "b,s,<,>,h,l"

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- appearance
vim.cmd.colorscheme('tokyonight-night')

vim.opt.number = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.scrolloff = 5
vim.opt.mouse = "a"

local os = vim.loop.os_uname().sysname
if os == "Darwin" then
  vim.opt.guifont = "DejaVuSansM Nerd Font Mono:h14"
elseif os == "Linux" then
  vim.opt.guifont = "DejaVuSansM Nerd Font Mono 14"
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
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.wildmenu = true

vim.opt.wildignore = table.concat({
  "*/.git/*,*/.hg/*,*/.svn/*",
  "*/target/*,*.class,*.jar",
  "*.o,*.so",
  "*.pyc"
}, ',')

-- keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>')

vim.keymap.set('n', '<leader>q', ':q<cr>')

vim.keymap.set('n', '<leader>fw', ':w<cr>')
vim.keymap.set('n', '<leader>ff', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')


vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>')

-- shifting without leaving selection mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- windows
vim.keymap.set('n', '<c-h>', '<c-W>h')
vim.keymap.set('n', '<c-j>', '<c-W>j')
vim.keymap.set('n', '<c-k>', '<c-W>k')
vim.keymap.set('n', '<c-l>', '<c-W>l')

vim.keymap.set('n', '<leader>wh', ':topleft vnew<cr>')
vim.keymap.set('n', '<leader>wj', ':botright new<cr>')
vim.keymap.set('n', '<leader>wk', ':topleft new<cr>')
vim.keymap.set('n', '<leader>wl', ':botright vnew<cr>')

-- buffers
vim.keymap.set('n', '<tab>', ':BufferLineCycleNext<cr>')
vim.keymap.set('n', '<s-tab>', ':BufferLineCyclePrev<cr>')

-- bottom status line
require('lualine').setup({
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  }
})

-- tabs for open buffers
require('bufferline').setup({
  options = {
    numbers = "buffer_id",
    show_buffer_icons = true,
    buffer_close_icon = '✕'
  }
})

-- indent lines
require('ibl').setup()

-- better language parsing/highlights/formatting
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- these must always be installed
    "c", "lua", "vim", "vimdoc", "query",
    "python", "rust", "toml"
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
})

-- simple autoclose brackets/parens/etc
require('nvim-autopairs').setup()

-- fuzzy finder
local telescope = require('telescope')
telescope.setup({
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
})
telescope.load_extension('fzf')

-- language servers
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'clangd',
    'gopls',
    'lua_ls',
    'rust_analyzer'
  },
}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup{}

if vim.fn.executable('go') == 1 then
  lspconfig.gopls.setup{}
end

-- lua LS for vim config files
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }
})

-- rust lsp
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})

-- language specific settings
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {
    "*.rs",
    "*.py"
  },
  callback = function ()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end
})

-- lsp keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.keymap.set('n', '<leader>cd', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', '<leader>fr', ':Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>fs', ':Telescope lsp_document_symbols<cr>', opts)

    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  end,
})

-- rounded borders in lsp hover windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- diagnostic window
vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
})

-- completion
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp', keyword_length = 2 },
      { name = 'vsnip' },
    },
    {
      { name = 'buffer' },
    }
  )
})

