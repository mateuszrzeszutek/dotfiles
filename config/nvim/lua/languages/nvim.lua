local function setup(capabilities)
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
end

return {
  treesitter = { 'lua', 'vim', 'vimdoc', 'query' },
  lsp = { 'lua_ls' },
  setup = setup
}
