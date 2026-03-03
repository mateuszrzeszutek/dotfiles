local function setup(capabilities)
  vim.lsp.config('jdtls', {
    capabilities = capabilities
  })
end

return {
  treesitter = { 'java' },
  lsp = { 'jdtls' },
  setup = setup
}

