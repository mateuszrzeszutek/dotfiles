-- keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>')

vim.keymap.set('n', '<leader>q', ':q<cr>')

vim.keymap.set('n', '<leader>fw', ':w<cr>')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<leader>gf', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<cr>')

vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>')

-- shifting without leaving selection mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- windows
vim.keymap.set('n', '<c-h>', '<c-W>h')
vim.keymap.set('n', '<c-j>', '<c-W>j')
vim.keymap.set('n', '<c-k>', '<c-W>k')
vim.keymap.set('n', '<c-l>', '<c-W>l')

vim.keymap.set('n', '<leader>wh', ':topleft vnew<cr>')
vim.keymap.set('n', '<leader>wj', ':botright new<cr>')
vim.keymap.set('n', '<leader>wk', ':topleft new<cr>')
vim.keymap.set('n', '<leader>wl', ':botright vnew<cr>')

-- buffers
vim.keymap.set('n', '<tab>', ':BufferLineCycleNext<cr>')
vim.keymap.set('n', '<s-tab>', ':BufferLineCyclePrev<cr>')
vim.keymap.set('n', '<leader>bq', ':bdelete<cr>')
vim.keymap.set('n', '<leader>bb', ':Telescope buffers<cr>')

