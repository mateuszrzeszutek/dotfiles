local function setup(capabilities)
  vim.lsp.config('fish_lsp', {
    capabilities = capabilities
  })
end

return {
  treesitter = { 'fish' },
  lsp = { 'fish_lsp' },
  setup = setup
}
