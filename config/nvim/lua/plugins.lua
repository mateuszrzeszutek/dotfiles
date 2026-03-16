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
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",

  -- dark color theme
  { 'Shatur/neovim-ayu' },

  -- bottom status line
  { 'nvim-lualine/lualine.nvim',          dependencies = { 'nvim-tree/nvim-web-devicons' } },

  -- buffer tabs on top
  { 'akinsho/bufferline.nvim' },

  -- shows indentation
  { 'lukas-reineke/indent-blankline.nvim' },

  -- treesitter grammar parsers
  {
    'nvim-treesitter/nvim-treesitter',
    -- nvim-treesitter people went nuts and are requiring nightly version of nvim
    commit = '4110daee15fdf1a2030a2c989e6f240b31d6f5e6',
    pin = true,
    build = ':TSUpdate'
  },

  -- auto closes parentheses and such
  { 'windwp/nvim-autopairs' },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-ui-select.nvim' },

  -- LSP support
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },

  -- completion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- snippets, required for nvim-cmp
  { 'hrsh7th/vim-vsnip' },
  { 'hrsh7th/cmp-vsnip' },

  -- debug adapter protocol
  { 'mfussenegger/nvim-dap' },

  -- generic test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
    }
  },

  -- git blame & line changes
  { 'lewis6991/gitsigns.nvim' },

  -- better diagnostic (and others) windows
  { 'folke/trouble.nvim' },

  -- keymap help window
  { 'folke/which-key.nvim' },

  -- file tree
  { 'nvim-tree/nvim-tree.lua' },

  -- java language server support
  { 'mfussenegger/nvim-jdtls' },
  -- java test runner
  { 'andrewyazura/neotest-gradle' },

  -- rust support
  { 'mrcjkb/rustaceanvim' }
})
