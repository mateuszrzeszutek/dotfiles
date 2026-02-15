local M = {}

M.treesitter = {'bash'}

M.lsp = {'bashls'}

M.setup = function (capabilities)
  vim.lsp.config('bashls', {
    capabilities = capabilities
  })
end

return M

