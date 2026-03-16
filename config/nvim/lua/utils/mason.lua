local function ensure_installed(pkg_names)
  local mason = require('mason-registry')
  mason.refresh(function()
    for _, pkg_name in ipairs(pkg_names) do
      local p = mason.get_package(pkg_name)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

local function glob_registry(path, excluded_files)
  excluded_files = excluded_files or {}

  local result = {}
  local files = vim.fn.split(vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages' .. path, true), '\n')
  for _, file in ipairs(files) do
    local fname = vim.fn.fnamemodify(file, ':t')
    if not vim.tbl_contains(excluded_files, fname) then
      table.insert(result, file)
    end
  end
  return result
end

return {
  ensure_installed = ensure_installed,
  glob_registry = glob_registry
}
