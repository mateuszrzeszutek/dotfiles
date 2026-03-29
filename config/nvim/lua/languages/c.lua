local function setup(capabilities)
  vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = { 'clangd', '--enable-config' }
  })
end

return {
  treesitter = { 'c' },
  lsp = { 'clangd' },
  setup = setup
}
