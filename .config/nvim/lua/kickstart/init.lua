require("kickstart.remaps")
require("kickstart.options")
require("kickstart.lazy_bootstrap")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim.filetype.add({
--   pattern = {
--     [".*"] = {
--       function(path, buf)
--         return vim.bo[buf].filetype ~= "bigfile" and path and vim.fn.getfsize(path) > vim.g.bigfile_size and "bigfile"
--           or nil
--       end,
--     },
--   },
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   -- group = augroup("bigfile"),
--   group = vim.api.nvim_create_augroup("aug_bigfile", { clear = true }),
--   pattern = "bigfile",
--   callback = function(ev)
--     print("bigfile")
--     vim.b.minianimate_disable = true
--     vim.schedule(function()
--       -- vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
--       vim.bo[ev.buf].syntax = ""
--     end)
--   end,
-- })
