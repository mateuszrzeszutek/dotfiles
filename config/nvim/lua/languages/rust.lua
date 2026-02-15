local M = {}

local function set_tab_length(tab_length)
  vim.opt_local.shiftwidth = tab_length
  vim.opt_local.tabstop = tab_length
  vim.opt_local.softtabstop = tab_length
end

M.treesitter = {'rust', 'toml'}

M.lsp = {'rust_analyzer'}

M.setup = function (capabilities)
  vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
  })

  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {
      "*.rs"
    },
    callback = function (ev)
      local opts = { buffer = ev.buf }

      set_tab_length(4)

      vim.keymap.set('n', '<leader>cf', ':RustFmt<cr>', opts)
      vim.keymap.set('n', '<leader>ct', ':RustTest!<cr>', opts)
    end
  })
end

return M

