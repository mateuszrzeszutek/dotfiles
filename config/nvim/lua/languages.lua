-- better language parsing/highlights/formatting
require('nvim-treesitter').install {
  -- these must always be installed
  "c", "lua", "vim", "vimdoc", "query",
  "python", "rust", "toml"
}

-- simple autoclose brackets/parens/etc
require('nvim-autopairs').setup()

-- language servers
local has_go = vim.fn.executable('go') == 1
local lsps = {
  'clangd',
  'lua_ls',
  'rust_analyzer'
}
if has_go then
  table.insert(lsps, 'gopls')
end

require('mason').setup()
require('mason-lspconfig').setup {
  automatic_enable = true,
  ensure_installed = lsps,
}

local function set_tab_length(tab_length)
  vim.opt_local.shiftwidth = tab_length
  vim.opt_local.tabstop = tab_length
  vim.opt_local.softtabstop = tab_length
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- c
vim.lsp.config('clangd', {
  capabilities = capabilities
})

-- go
if has_go then
  vim.lsp.enable('gopls')

  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
      "*.go"
    },
    callback = function (ev)
      local opts = { buffer = ev.buf }

      vim.keymap.set('n', '<leader>cf', ':GoFmt<cr>', opts)
      vim.keymap.set('n', '<leader>ct', ':GoTest<cr>', opts)
    end
  })
end

-- lua LS for vim config files
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
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


-- python
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {
    "*.py"
  },
  callback = function ()
    set_tab_length(4)
  end
})

-- rust
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {
    "*.rs"
  },
  callback = function (ev)
    local opts = { buffer = ev.buf }

    set_tab_length(4)

    vim.keymap.set('n', '<leader>cf', ':RustFmt<cr>', opts)
    vim.keymap.set('n', '<leader>ct', ':RustTest!<cr>', opts)
  end
})

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

