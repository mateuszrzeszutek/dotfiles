local function setup(capabilities)
  vim.lsp.config('bashls', {
    capabilities = capabilities
  })
end

return {
  treesitter = { 'bash' },
  lsp = { 'bashls' },
  setup = setup
}
