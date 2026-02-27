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
local k = require('keymap')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    k.setup_lsp_keymaps(ev.buf)
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
