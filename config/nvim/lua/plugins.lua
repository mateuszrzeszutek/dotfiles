local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
    branch = 'main',
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

  -- LSP support
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },

  -- completion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  -- snippets, required for nvim-cmp
  { 'hrsh7th/vim-vsnip' },
  { 'hrsh7th/cmp-vsnip' },

  -- git blame & line changes
  { 'lewis6991/gitsigns.nvim' },

  -- better diagnostic (and others) windows
  { 'folke/trouble.nvim' },

  -- keymap help window
  { 'folke/which-key.nvim' },

  -- file tree
  { 'nvim-tree/nvim-tree.lua' }
})
