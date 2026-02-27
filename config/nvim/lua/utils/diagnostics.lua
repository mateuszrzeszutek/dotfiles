local function goto_diagnostic(diagnostic, opts)
  if not diagnostic then
    vim.api.nvim_echo({ { 'No more valid diagnostics to move to', 'WarningMsg' } }, true, {})
    return
  end
  opts = opts or {}
  opts = vim.tbl_deep_extend('force', opts, {
    float = true,
    diagnostic = diagnostic
  })
  return vim.diagnostic.jump(opts)
end
local function prev_diagnostic(opts)
  return goto_diagnostic(vim.diagnostic.get_prev(opts), opts)
end
local function next_diagnostic(opts)
  return goto_diagnostic(vim.diagnostic.get_next(opts), opts)
end

return {
  prev_diagnostic = prev_diagnostic,
  next_diagnostic = next_diagnostic
}
