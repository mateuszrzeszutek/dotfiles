local M = {}

local function set_tab_length(tab_length)
  vim.opt_local.shiftwidth = tab_length
  vim.opt_local.tabstop = tab_length
  vim.opt_local.softtabstop = tab_length
end

M.treesitter = {'python'}

M.lsp = {}

M.setup = function (capabilities)
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
      "*.py"
    },
    callback = function ()
      set_tab_length(4)
    end
  })
end

return M

