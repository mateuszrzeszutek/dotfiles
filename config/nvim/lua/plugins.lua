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
  -- appearance
  { 'Shatur/neovim-ayu' },
  { 'nvim-lualine/lualine.nvim',          dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'akinsho/bufferline.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },

  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate'
  },
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
  -- snippets -- required for cmp
  { 'hrsh7th/vim-vsnip' },
  { 'hrsh7th/cmp-vsnip' },

  { 'lewis6991/gitsigns.nvim' },
  { 'folke/trouble.nvim' },

  -- keymap help window
  { 'folke/which-key.nvim' }
})
