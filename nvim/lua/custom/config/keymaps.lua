vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
-- git
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, {desc = 'Git blame a line'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

vim.keymap.set('n', '<C-a>', 'gg<S-v>G', {})
vim.keymap.set('n', '<C-s>', vim.cmd.write, {})


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
local range_formatting = function()
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    vim.lsp.buf.format({
        range = {
            ["start"] = { start_row, 0 },
            ["end"] = { end_row, 0 },
        },
        async = true,
    })
end
vim.keymap.set("v", "<leader>f", range_formatting, { desc = "Range Formatting" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

-- Competitive programming
vim.keymap.set('n', '<F8>', ':!g++ -std=c++17 -Wshadow -Wall -o %:r % -O2 -Wno-unused-result<CR>')
vim.keymap.set('n', '<F9>',
    ':!g++ -std=c++17 -Wshadow -Wall -o %:r % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR>')
vim.keymap.set('n', '<F10>', ':split<CR>:terminal %:r<CR>')

-- LuaSnip
vim.keymap.set({ 'i', 's' }, '<c-n>', "<cmd>lua require'luasnip'.jump(1)<CR>", { noremap = true, silent = true })
vim.keymap.set({ 'i', 's' }, '<c-p>', "<cmd>lua require'luasnip'.jump(-1)<CR>", { noremap = true, silent = true })

-- ESC to leave terminal mode
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-\\><C-n>")

-- windows navigation
vim.keymap.set('n', '<leader>-', ':split<CR><C-w>w', {})
vim.keymap.set('n', '<leader>\\', ':vsplit<CR><C-w>w', {})
vim.keymap.set('n', '<C-H>', '<C-w>h', {})
vim.keymap.set('n', '<C-J>', '<C-w>j', {})
vim.keymap.set('n', '<C-K>', '<C-w>k', {})
vim.keymap.set('n', '<C-L>', '<C-w>l', {})

-- Resize window
vim.keymap.set('n', '<C-w>h', '<C-w>5<', {})
vim.keymap.set('n', '<C-w>l', '<C-w>5>', {})
vim.keymap.set('n', '<C-w>k', '<C-w>5-', {})
vim.keymap.set('n', '<C-w>j', '<C-w>5+', {})

-- tabs
vim.keymap.set('n', ']b', ':bn<CR>', {})
vim.keymap.set('n', '[b', ':bp<CR>', {})

-- reload init.lua
vim.keymap.set('n', '<leader><leader>', ':source ~/.config/nvim/init.lua<CR>', {})

