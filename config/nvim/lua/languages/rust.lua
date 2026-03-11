local function set_tab_length(tab_length)
  vim.opt_local.shiftwidth = tab_length
  vim.opt_local.tabstop = tab_length
  vim.opt_local.softtabstop = tab_length
end

local function setup()
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
      "*.rs"
    },
    callback = function()
      set_tab_length(4)
    end
  })
end

return {
  treesitter = { 'rust', 'toml' },
  lsp = { 'rust_analyzer' },
  neotest = require('rustaceanvim.neotest'),
  setup = setup
}
