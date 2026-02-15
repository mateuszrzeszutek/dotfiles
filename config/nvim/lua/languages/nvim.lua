local M = {}

M.treesitter = {'lua', 'vim', 'vimdoc', 'query'}

M.lsp = {'lua_ls'}

M.setup = function (capabilities)
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

return M

