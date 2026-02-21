local function set_tab_length(tab_length)
  vim.opt_local.shiftwidth = tab_length
  vim.opt_local.tabstop = tab_length
  vim.opt_local.softtabstop = tab_length
end

local function setup(capabilities)
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = {
      "*.py"
    },
    callback = function()
      set_tab_length(4)
    end
  })
end

return {
  treesitter = { 'python' },
  lsp = {},
  setup = setup
}
