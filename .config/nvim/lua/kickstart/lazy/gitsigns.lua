return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    numhl = true,
    current_line_blame_opts = {
      delay = 2000,
      virt_text_pos = "eol",
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[S]tage current [H]unk" })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[R]eset current [H]unk" })
      map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        { desc = "[S]tage [H]unk" })
      map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        { desc = "[R]eset [H]unk" })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "[S]tage [B]uffer" })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "[U]ndo stage [H]unk" })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "[R]eset [B]uffer" })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[P]review [H]unk" })
      map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "[B]lame current line" })
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "[T]oggle [B]lame current line" })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = "[D]iff current line" })
      map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "[D]iff current line against HEAD" })
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted" })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
  },
}
