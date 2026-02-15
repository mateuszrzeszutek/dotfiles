local M = {}

M.treesitter = {'fish'}

M.lsp = {'fish_lsp'}

M.setup = function (capabilities)
  vim.lsp.config('fish_lsp', {
    capabilities = capabilities
  })
end

return M


