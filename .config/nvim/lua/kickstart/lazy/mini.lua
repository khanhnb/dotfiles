return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
      -- require("mini.statusline").setup({
      --   use_icons = false,
      --   use_lsp = true,
      --   section_location = function() return "%2l:%-2v" end
      -- })
    end,
  },
}
