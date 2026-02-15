local M = {}

M.treesitter = {'c'}

M.lsp = {'clangd'}

M.setup = function (capabilities)
  vim.lsp.config('clangd', {
    capabilities = capabilities
  })
end

return M
