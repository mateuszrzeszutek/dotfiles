local nvim_tree = require("nvim-tree.api")

local function focus_or_toggle()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })
  if current_buf_ft == "NvimTree" then
    nvim_tree.tree.close()
  else
    nvim_tree.tree.find_file({
      open = true,
      focus = true,
      update_root = true
    })
  end
end

return {
  focus_or_toggle = focus_or_toggle
}
