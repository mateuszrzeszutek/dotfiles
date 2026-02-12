-- general
vim.opt.autoread = true

vim.opt.whichwrap = "b,s,<,>,h,l"

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- appearance
vim.opt.number = true
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.scrolloff = 5
vim.opt.mouse = "a"

-- line breaks
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

-- indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- completion
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.wildmenu = true

vim.opt.wildignore = table.concat({
  "*/.git/*,*/.hg/*,*/.svn/*",
  "*/target/*,*.class,*.jar",
  "*.o,*.so",
  "*.pyc"
}, ',')

