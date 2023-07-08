-- dont use system's clipboard
vim.o.clipboard = ''
vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

-- vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.o.colorcolumn = "80"

-- cursorline - underline
vim.o.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })

vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↵"

