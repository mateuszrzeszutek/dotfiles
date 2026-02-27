require('ayu').colorscheme()

local os = vim.uv.os_uname().sysname
if os == "Darwin" then
  vim.opt.guifont = "DejaVuSansM Nerd Font Mono:h14"
elseif os == "Linux" then
  vim.opt.guifont = "DejaVuSansM Nerd Font Mono 14"
end

-- bottom status line
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'ayu',
  }
})

-- tabs for open buffers
require('bufferline').setup({
  options = {
    numbers = "buffer_id",
    show_buffer_icons = true,
    buffer_close_icon = '✕'
  }
})

-- indent lines
require('ibl').setup()

-- git blame & highlights
require('gitsigns').setup {
  current_line_blame = true,
  numhl = true
}

-- pretty diagnostic window
require('trouble').setup {
}

-- diagnostic dialog
vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
})

-- fuzzy finder dialog
local telescope = require('telescope')
local open_with_trouble = require("trouble.sources.telescope").open
telescope.setup({
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
telescope.load_extension('fzf')

-- keymap help window
require('which-key').setup({
  preset = 'helix'
})

-- file tree
require('nvim-tree').setup()
