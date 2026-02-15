local M = {}

local has_go = vim.fn.executable('go') == 1

M.treesitter = has_go and {'go'} or {}

M.lsp = has_go and {'gopls'} or {}

M.setup = function (capabilities)
  if has_go then
    vim.lsp.config('gopls', {
      capabilities = capabilities
    })

    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
      pattern = {
        "*.go"
      },
      callback = function (ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', '<leader>cf', ':GoFmt<cr>', opts)
        vim.keymap.set('n', '<leader>ct', ':GoTest<cr>', opts)
      end
    })
  end
end

return M

