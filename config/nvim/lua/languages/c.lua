local function setup(capabilities)
  vim.lsp.config('clangd', {
    capabilities = capabilities
  })
end

return {
  treesitter = { 'c' },
  lsp = { 'clangd' },
  setup = setup
}
