return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      -- suggestion = {
      -- 	auto_trigger = true,
      -- 	keymap = {
      -- 		-- accept = "<CR>",
      -- 		accept = "<Tab>",
      -- 	},
      -- },
    })
  end,
}
