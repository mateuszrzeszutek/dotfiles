local function gh(name)
  return {
    src = 'https://github.com/' .. name
  }
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'update' and kind ~= 'insert' then
      return
    end
    if name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end
})

vim.pack.add({
  -- dark color theme
  gh('Shatur/neovim-ayu'),

  -- bottom status line
  gh('nvim-lualine/lualine.nvim'),
  -- dep: nerd font icons
  gh('nvim-tree/nvim-web-devicons'),

  -- buffer tabs on top
  gh('akinsho/bufferline.nvim'),

  -- shows indentation
  gh('lukas-reineke/indent-blankline.nvim'),

  -- treesitter grammar parsers
  gh('nvim-treesitter/nvim-treesitter'),

  -- auto closes parentheses and such
  gh('windwp/nvim-autopairs'),

  -- fuzzy finder
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-fzf-native.nvim'),
  gh('nvim-telescope/telescope-file-browser.nvim'),
  gh('nvim-telescope/telescope-ui-select.nvim'),
  -- dep: function library
  gh('nvim-lua/plenary.nvim'),

  -- LSP support
  gh('williamboman/mason.nvim'),
  gh('williamboman/mason-lspconfig.nvim'),
  gh('neovim/nvim-lspconfig'),

  -- completion
  gh('hrsh7th/nvim-cmp'),
  gh('hrsh7th/cmp-nvim-lsp'),
  gh('hrsh7th/cmp-nvim-lsp-signature-help'),
  -- snippets, required for nvim-cmp
  gh('hrsh7th/vim-vsnip'),
  gh('hrsh7th/cmp-vsnip'),

  -- debug adapter protocol
  gh('mfussenegger/nvim-dap'),

  -- generic test runner
  gh("nvim-neotest/neotest"),
  gh("nvim-neotest/nvim-nio"),
  gh("antoinemadec/FixCursorHold.nvim"),

  -- git blame & line changes
  gh('lewis6991/gitsigns.nvim'),

  -- better diagnostic (and others) windows
  gh('folke/trouble.nvim'),

  -- keymap help window
  gh('folke/which-key.nvim'),

  -- file tree
  gh('nvim-tree/nvim-tree.lua'),

  -- java language server support
  gh('mfussenegger/nvim-jdtls'),
  -- java test runner
  gh('andrewyazura/neotest-gradle'),

  -- rust support
  gh('mrcjkb/rustaceanvim')
})

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, {});
