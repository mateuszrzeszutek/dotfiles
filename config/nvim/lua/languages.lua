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

local function hover(opts)
  opts = opts or {}
  -- add borders to LSP hover window
  opts = vim.tbl_deep_extend('force', opts, {
    border = 'rounded'
  })
  return vim.lsp.buf.hover(opts)
end

local function goto_diagnostic(diagnostic, opts)
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
local function prev_diagnostic(opts)
  return goto_diagnostic(vim.diagnostic.get_prev(opts), opts)
end
local function next_diagnostic(opts)
  return goto_diagnostic(vim.diagnostic.get_next(opts), opts)
end

local k = require('keymap')
local nmap, ngroup = k.nmap, k.ngroup

-- lsp keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local b = ev.buf

    ngroup('<leader>l', 'LSP')
    nmap('<leader>lf', vim.lsp.buf.format, 'Format buffer', b)
    nmap('<leader>ld', ':Trouble diagnostics toggle<cr>', 'Toggle diagnostics window', b)
    nmap('<leader>ls', ':Trouble symbols toggle<cr>', 'Toggle symbols window', b)
    nmap('<leader>lr', ':Telescope lsp_references<cr>', 'Search for current symbol\'s references', b)
    nmap('<leader>lS', ':Telescope lsp_dynamic_workspace_symbols<cr>', 'Search for symbols in workspace', b)

    nmap('K', hover, 'Display information about current symbol', b)

    nmap('[d', prev_diagnostic, 'Previous diagnostic', b)
    nmap(']d', next_diagnostic, 'Next diagnostic', b)

    nmap('<a-cr>', vim.lsp.buf.code_action, 'Code action', b)
    nmap('<F2>', vim.lsp.buf.rename, 'Rename symbol', b)

    nmap('gD', vim.lsp.buf.declaration, 'Go to declaration', b)
    nmap('gd', vim.lsp.buf.definition, 'Go to definition', b)
    nmap('gi', vim.lsp.buf.implementation, 'Go to implementation', b)
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
