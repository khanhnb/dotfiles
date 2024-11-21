return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- require("mini.ai").setup()
      require("mini.surround").setup()
      -- require("mini.pairs").setup()
      -- require('mini.diff').setup({ view = { style = 'sign' } })
      -- require('mini.git').setup()
      -- require("mini.statusline").setup({
      --   use_icons = false,
      --   -- use_lsp = false,
      --   -- section_location = function() return "%2l:%-2v" end,
      --   content = {
      --     -- Mode component settings
      --     active = function()
      --       local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      --       local git           = MiniStatusline.section_git({ trunc_width = 75 })
      --       local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      --       local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      --       local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      --       local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      --       local location      = MiniStatusline.section_location({ trunc_width = 75 })
      --
      --       return MiniStatusline.combine_groups({
      --         { hl = mode_hl,                 strings = { mode } },
      --         { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
      --         '%<', -- Mark truncation point
      --         { hl = 'MiniStatuslineFilename', strings = { filename } },
      --         '%=', -- End left alignment
      --         { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      --         { hl = mode_hl,                  strings = { location } },
      --       })
      --     end,
      --     -- Inactive window settings
      --     inactive = function()
      --       local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      --
      --       return MiniStatusline.combine_groups({
      --         { hl = 'MiniStatuslineInactive', strings = { filename } },
      --       })
      --     end,
      --   },
      --
      -- })
    end,
  },
}
