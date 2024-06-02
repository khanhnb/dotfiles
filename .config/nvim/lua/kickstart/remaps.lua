vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)

-- some remaps from ThePrimagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-a>", "gg<S-v>G", {})
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Competitive programming
vim.keymap.set("n", "<F8>", ":!g++ -std=c++17 -Wshadow -Wall -o %:r % -O2 -Wno-unused-result<CR>")
vim.keymap.set(
  "n",
  "<F9>",
  ":!g++ -std=c++17 -Wshadow -Wall -o %:r % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR>"
)
-- vim.keymap.set('n', '<F10>', ':split<CR>:terminal %:r<CR>')
vim.keymap.set("n", "<F10>", ":terminal %:r<CR>")

-- ESC to leave terminal mode
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-\\><C-n>")

-- windows splits
vim.keymap.set("n", "<leader>-", ":split<CR><C-w>w", {})
vim.keymap.set("n", "<leader>\\", ":vsplit<CR><C-w>w", {})

-- Resize window
vim.keymap.set("n", "<C-w>h", "<C-w>5<", {})
vim.keymap.set("n", "<C-w>l", "<C-w>5>", {})
vim.keymap.set("n", "<C-w>k", "<C-w>5-", {})
vim.keymap.set("n", "<C-w>j", "<C-w>5+", {})

-- windows navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- buffers
vim.keymap.set("n", "]b", ":bn<CR>", {})
vim.keymap.set("n", "[b", ":bp<CR>", {})

-- diagnostic
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to next [E]rror message" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to previous [E]rror message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
