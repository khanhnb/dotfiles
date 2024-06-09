return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", ":0G<CR>", { desc = "Git status" })
    vim.keymap.set("n", "<leader>gb", require("gitsigns").blame_line, { desc = "Git blame a line" })
    vim.keymap.set("n", "<leader>gc", ':Git commit -m "', { noremap = false })
    vim.keymap.set("n", "<leader>gP", ":Git push -u origin HEAD<CR>", { noremap = false })
    vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { noremap = false })
    vim.keymap.set("n", "<leader>gl", ":Git lg<CR>", { noremap = false })
  end
}
