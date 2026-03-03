local function hover(opts)
  opts = opts or {}
  -- add borders to LSP hover window
  opts = vim.tbl_deep_extend('force', opts, {
    border = 'rounded'
  })
  return vim.lsp.buf.hover(opts)
end

return {
  hover = hover,
}
