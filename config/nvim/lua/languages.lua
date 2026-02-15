local languages = {
  require('languages.bash'),
  require('languages.c'),
  require('languages.fish'),
  require('languages.go'),
  require('languages.nvim'),
  require('languages.python'),
  require('languages.rust'),
}

-- better language parsing/highlights/formatting
local treesitter_parsers = {}
for _, l in pairs(languages) do
  for _, p in pairs(l.treesitter) do
    treesitter_parsers[p] = p
  end
end

require('nvim-treesitter').install(treesitter_parsers)

-- language servers
local lsp_servers = {}
for _, l in pairs(languages) do
  for _, p in pairs(l.lsp) do
    table.insert(lsp_servers, p)
  end
end

require('mason').setup()
require('mason-lspconfig').setup {
  automatic_enable = true,
  ensure_installed = lsp_servers,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, l in pairs(languages) do
  l.setup(capabilities)
end

-- simple autoclose brackets/parens/etc
require('nvim-autopairs').setup()

-- lsp keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)

    local function hover(opts)
      opts = opts or {}
      -- add borders to LSP hover window
      opts = vim.tbl_deep_extend('force', opts, {
        border = 'rounded'
      })
      return vim.lsp.buf.hover(opts)
    end

    local goto_diagnostic = function(diagnostic, opts)
      if not diagnostic then
        vim.api.nvim_echo({ { 'No more valid diagnostics to move to', 'WarningMsg' } }, true, {})
        return
      end
      opts = opts or {}
      opts = vim.tbl_deep_extend('force', opts, {
        float = true,
        diagnostic = diagnostic
      })
      return vim.diagnostic.jump(opts)
    end
    local prev_diagnostic = function(opts)
      return goto_diagnostic(vim.diagnostic.get_prev(opts), opts)
    end
    local next_diagnostic = function(opts)
      return goto_diagnostic(vim.diagnostic.get_next(opts), opts)
    end

    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'K', hover, opts)

    vim.keymap.set('n', '[d', prev_diagnostic, opts)
    vim.keymap.set('n', ']d', next_diagnostic, opts)

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>cd', ':Trouble diagnostics toggle<cr>', opts)
    vim.keymap.set('n', '<leader>cs', ':Trouble symbols toggle<cr>', opts)

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', '<leader>fr', ':Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>fs', ':Telescope lsp_document_symbols<cr>', opts)
    vim.keymap.set('n', '<leader>fS', ':Telescope lsp_dynamic_workspace_symbols<cr>', opts)

  end,
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

