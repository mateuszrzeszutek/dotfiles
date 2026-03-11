local wk = require('which-key')

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

local function xmap(lhs, rhs, desc, buffer)
  wk.add({
    { lhs, rhs, desc = desc, mode = 'x', buffer = buffer }
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
  nmap('<leader>ft', require('utils.nvim-tree').focus_or_toggle, 'Toggle file tree')

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

local function setup_general_lsp(buffer_id)
  local lsp = require('utils.lsp')

  ngroup('<leader>l', 'LSP')
  nmap('<leader>lf', vim.lsp.buf.format, 'Format buffer', buffer_id)
  nmap('<leader>ld', ':Trouble diagnostics toggle<cr>', 'Toggle diagnostics window', buffer_id)
  nmap('<leader>ls', ':Trouble symbols toggle<cr>', 'Toggle symbols window', buffer_id)
  nmap('<leader>lr', ':Telescope lsp_references<cr>', 'Search for current symbol\'s references', buffer_id)
  nmap('<leader>lS', ':Telescope lsp_dynamic_workspace_symbols<cr>', 'Search for symbols in workspace', buffer_id)
  nmap('<leader>lh', lsp.toggle_inlay_hints, 'Toggle inlay hints', buffer_id)

  nmap('K', lsp.hover, 'Display information about current symbol', buffer_id)

  local diag = require('utils.diagnostics')
  nmap('[d', diag.prev_diagnostic, 'Previous diagnostic', buffer_id)
  nmap(']d', diag.next_diagnostic, 'Next diagnostic', buffer_id)

  nmap('<a-cr>', vim.lsp.buf.code_action, 'Code action', buffer_id)
  xmap('<a-cr>', vim.lsp.buf.code_action, 'Code action', buffer_id)

  nmap('<F2>', vim.lsp.buf.rename, 'Rename symbol', buffer_id)

  nmap('gD', vim.lsp.buf.declaration, 'Go to declaration', buffer_id)
  nmap('gd', vim.lsp.buf.definition, 'Go to definition', buffer_id)
  nmap('gi', vim.lsp.buf.implementation, 'Go to implementation', buffer_id)

  local neotest = require('neotest')
  local run_all_tests_in_file = function() neotest.run.run(vim.fn.expand("%")) end
  ngroup('<leader>t', 'Tests')
  nmap('<leader>tt', neotest.run.run, 'Run nearest test', buffer_id)
  nmap('<leader>tT', run_all_tests_in_file, 'Run all tests in current file', buffer_id)
  nmap('<leader>ts', neotest.run.stop, 'Stop running tests', buffer_id)
  nmap('<leader>to', neotest.output_panel.toggle, 'Toggle test output', buffer_id)
  nmap('<leader>tO', neotest.summary.toggle, 'Toggle test summary', buffer_id)
end

return {
  setup = setup,
  setup_general_lsp = setup_general_lsp
}
