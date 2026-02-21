if vim.fn.executable('go') ~= 1 then
  return {
    treesitter = {},
    lsp = {},
    setup = function()
    end
  }
end

local function setup(capabilities)
  vim.lsp.config('gopls', {
    capabilities = capabilities
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
      "*.go"
    },
    callback = function(ev)
      local opts = { buffer = ev.buf }

      vim.keymap.set('n', '<leader>ct', ':GoTest<cr>', opts)
    end
  })
end

return {
  treesitter = { 'go' },
  lsp = { 'gopls' },
  setup = setup
}
