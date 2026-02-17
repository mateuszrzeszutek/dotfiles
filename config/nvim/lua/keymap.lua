vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local wk = require('which-key')

local function ngroup(lhs, group)
  wk.add({
    { lhs, group = group, mode = 'n' }
  })
end

local function nmap(lhs, rhs, desc, buffer)
  wk.add({
    { lhs, rhs, desc = desc, mode = 'n', buffer = buffer }
  })
end

local function setup()
  vim.keymap.set('n', '<esc>', '<esc>:noh<cr>')

  nmap('<leader>q', ':q<cr>', 'Quit')
  nmap('<leader>/', ':Telescope live_grep<cr>', 'Grep files in workspace')
  nmap('<leader>.', ':Telescope resume<cr>', 'Resume last search')

  ngroup('<leader>f', 'Files')
  nmap('<leader>fw', ':w<cr>', 'Write current file')
  nmap('<leader>ff', ':Telescope find_files<cr>', 'Find files in workspace')
  nmap('<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<cr>', 'Browse files in current directory')
  nmap('<leader>fB', ':Telescope file_browser<cr>', 'Browse files in workspace')

  ngroup('<leader>g', 'Git')
  nmap('<leader>gf', ':Telescope git_files<cr>', 'List files in git repository')
  nmap('<leader>gb', ':Telescope git_branches<cr>', 'List git branches')
  nmap('<leader>gB', ':Gitsigns blame<cr>', 'Toggle git blame')

  ngroup('<leader>b', 'Buffers')
  nmap('<tab>', ':BufferLineCycleNext<cr>', 'Next buffer')
  nmap('<s-tab>', ':BufferLineCyclePrev<cr>', 'Previous buffer')
  nmap('<leader>bq', ':bdelete<cr>', 'Close current buffer')
  nmap('<leader>bb', ':Telescope buffers<cr>', 'List buffers')

  ngroup('<leader>v', 'NVim config')
  nmap('<leader>vs', ':source $MYVIMRC<cr>', 'Reload nvim config')
  nmap('<leader>ve', ':edit $MYVIMRC<cr>', 'Edit nvim config')

  ngroup('<leader>w', 'Windows')
  nmap('<leader>ws', ':split<cr>', 'Split horizontally')
  nmap('<leader>wv', ':vsplit<cr>', 'Split vertically')
  nmap('<leader>wh', '<c-W>h', 'Jump to left window')
  nmap('<leader>wj', '<c-W>j', 'Jump to bottom window')
  nmap('<leader>wk', '<c-W>k', 'Jump to top window')
  nmap('<leader>wl', '<c-W>l', 'Jump to right window')

  -- shifting without leaving selection mode
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')
end

return {
  ngroup = ngroup,
  nmap = nmap,
  setup = setup
}
