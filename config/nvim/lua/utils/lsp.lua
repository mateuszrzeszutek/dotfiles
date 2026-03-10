local function hover(opts)
  opts = opts or {}
  -- add borders to LSP hover window
  opts = vim.tbl_deep_extend('force', opts, {
    border = 'rounded'
  })
  return vim.lsp.buf.hover(opts)
end

local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

return {
  hover = hover,
  toggle_inlay_hints = toggle_inlay_hints
}
