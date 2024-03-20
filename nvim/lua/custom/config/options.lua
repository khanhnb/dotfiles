-- dont use system's clipboard
vim.o.clipboard = ""
vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
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

vim.o.colorcolumn = "120"

-- cursorline - underline
vim.o.cursorline = true
-- vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.g.netrw_keepdir = 0

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append("eol:↵")
vim.opt.guicursor = ""

-- lsp round border
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})

require("lspconfig.ui.windows").default_options = {
	border = _border,
}

vim.cmd.colorscheme("catppuccin")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 0

-- require('ts_context_commentstring').setup {
--   enable_autocmd = false,
-- }

vim.opt.spelllang = "en_us"
-- vim.opt.spell = true
--
