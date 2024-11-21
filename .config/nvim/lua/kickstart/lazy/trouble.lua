return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      icons = {
        indent = {
          middle = " ",
          last = " ",
          top = " ",
          ws = "│  ",
        },
      },
      modes = {
        diagnostics = {
          groups = {
            { "filename", format = "{file_icon} {basename:Title} {count}" },
          },
          format = "{severity_icon} {message:md} {item.source} {hl:Comment}({code}){hl} {pos}",
        },
        lsp_base = {
          auto_refresh = false,
          params = {
            include_current = true,
          },
          -- format = "{text:ts} {item.client:Comment} {pos}",
        },
      },
    })
    -- trouble keymaps
    vim.keymap.set("n", "<leader>xx", function()
      require("trouble").toggle("diagnostics")
    end, { desc = "Toggle Trouble" })

    vim.keymap.set("n", "]t", function()
      require("trouble").next({ skip_groups = true, jump = true });
    end)

    vim.keymap.set("n", "[t", function()
      require("trouble").prev({ skip_groups = true, jump = true });
    end)

    vim.keymap.set("n", "gd", function()
      require("trouble").toggle({ mode = "lsp_definitions" })
    end, { desc = "[G]oto [D]efinition" })

    vim.keymap.set("n", "gr", function()
      require("trouble").toggle({ mode = "lsp_references" })
    end, { desc = "[G]oto [R]eferences" })

    vim.keymap.set("n", "gI", function()
      require("trouble").toggle({ mode = "lsp_implementations" })
    end, { desc = "[G]oto [I]mplementation" })

    vim.keymap.set("n", "<leader>D", function()
      require("trouble").toggle({ mode = "lsp_type_definitions" })
    end, { desc = "Type [D]efinition" })

    -- vim.keymap.set("n", "<leader>xw", function()
    --   require("trouble").toggle({ mode = "workspace_diagnostics" })
    -- end, { desc = "Trouble Workspace" })
    -- vim.keymap.set("n", "<leader>xd", function()
    --   require("trouble").toggle("document_diagnostics")
    -- end, { desc = "Trouble Document Diagnostics" })

    vim.keymap.set("n", "<leader>xq", function()
      require("trouble").toggle("quickfix")
    end, { desc = "Trouble Quickfix" })

    vim.keymap.set("n", "<leader>xl", function()
      require("trouble").toggle("loclist")
    end, { desc = "Trouble Loclist" })
  end
}
