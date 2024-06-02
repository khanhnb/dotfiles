return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      {
        -- settings without a patched font or icons
        focus = true,
        icons = false,
        fold_open = "v",      -- icon used for open folds
        fold_closed = ">",    -- icon used for closed folds
        indent_lines = false, -- add an indent guide below the fold icons
        signs = {
          -- icons / text used for a diagnostic
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info",
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      }

    })
    -- trouble keymaps
    vim.keymap.set("n", "<leader>xx", function()
      require("trouble").toggle("diagnostics")
    end, { desc = "Toggle Trouble" })
    vim.keymap.set("n", "[t", function()
      require("trouble").next({ mode = "diagnostics", skip_groups = true, jump = true });
    end)

    vim.keymap.set("n", "]t", function()
      require("trouble").prev({ mode = "diagnostics", skip_groups = true, jump = true });
    end)
    -- vim.keymap.set("n", "<leader>xw", function()
    --   require("trouble").toggle("workspace_diagnostics")
    -- end, { desc = "Trouble Workspace" })
    -- vim.keymap.set("n", "<leader>xd", function()
    --   require("trouble").toggle("document_diagnostics")
    -- end, { desc = "Trouble Document Diagnostics" })
    -- vim.keymap.set("n", "<leader>xq", function()
    --   require("trouble").toggle("quickfix")
    -- end, { desc = "Trouble Quickfix" })
    -- vim.keymap.set("n", "<leader>xl", function()
    --   require("trouble").toggle("loclist")
    -- end, { desc = "Trouble Loclist" })
    -- vim.keymap.set("n", "gR", function()
    --   require("trouble").toggle("lsp_references", {forcus = true})
    -- end, { desc = "Trouble LSP References" })
  end
}
