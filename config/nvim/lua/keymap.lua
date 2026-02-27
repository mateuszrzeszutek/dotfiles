local wk = require('which-key')
local lsp = require('utils.lsp')
local diag = require('utils.diagnostics')
local tree = require('utils.nvim-tree')

local function ngroup(lhs, group, proxy)
  wk.add({
    { lhs, group = group, proxy = proxy, mode = 'n' }
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
  nmap('<leader>ft', tree.focus_or_toggle, 'Toggle file tree')

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

  ngroup('<leader>w', 'Windows', '<c-w>')

  -- shifting without leaving selection mode
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')
end

local function setp_lsp_keymaps(buffer_id)
  ngroup('<leader>l', 'LSP')
  nmap('<leader>lf', vim.lsp.buf.format, 'Format buffer', buffer_id)
  nmap('<leader>ld', ':Trouble diagnostics toggle<cr>', 'Toggle diagnostics window', buffer_id)
  nmap('<leader>ls', ':Trouble symbols toggle<cr>', 'Toggle symbols window', buffer_id)
  nmap('<leader>lr', ':Telescope lsp_references<cr>', 'Search for current symbol\'s references', buffer_id)
  nmap('<leader>lS', ':Telescope lsp_dynamic_workspace_symbols<cr>', 'Search for symbols in workspace', buffer_id)

  nmap('K', lsp.hover, 'Display information about current symbol', buffer_id)

  nmap('[d', diag.prev_diagnostic, 'Previous diagnostic', buffer_id)
  nmap(']d', diag.next_diagnostic, 'Next diagnostic', buffer_id)

  nmap('<a-cr>', vim.lsp.buf.code_action, 'Code action', buffer_id)
  nmap('<F2>', vim.lsp.buf.rename, 'Rename symbol', buffer_id)

  nmap('gD', vim.lsp.buf.declaration, 'Go to declaration', buffer_id)
  nmap('gd', vim.lsp.buf.definition, 'Go to definition', buffer_id)
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation', buffer_id)
end

return {
  setup = setup,
  setup_lsp_keymaps = setp_lsp_keymaps
}
