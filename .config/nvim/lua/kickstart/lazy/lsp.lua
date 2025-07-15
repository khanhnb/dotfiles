return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    "j-hui/fidget.nvim",
    -- {
    --   "zbirenbaum/copilot-cmp",
    --   dependencies = "copilot.lua",
    --   opts = {
    --     event = { "InsertEnter", "LspAttach" },
    --     fix_pairs = true,
    --   },
    -- },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
    'saghen/blink.cmp',
  },

  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require("typescript-tools").setup({
      on_attach = function(_, buffer)
        vim.keymap.set("n", "<leader>co", ":TSToolsOrganizeImports<CR>",
          { buffer = buffer, desc = "[C]ode action [O]rganize imports" })
        vim.keymap.set("n", "<leader>cr", ":TSToolsRemoveUnused<CR>",
          { buffer = buffer, desc = "[C]ode action [R]emove unused" })
        vim.keymap.set("n", "<leader>cf", ":TSToolsFixAll<CR>",
          { buffer = buffer, desc = "[C]ode action [F]ix all" })
        vim.keymap.set("n", "<leader>cR", ":TSToolsRenameFile<CR>",
          { desc = "[C]ode action [R]ename File", buffer = buffer })
        vim.keymap.set("n", "gD", ":TSToolsGoToSourceDefinition<CR>",
          { desc = "[G]o to source [D]efinition", buffer = buffer })
        vim.keymap.set("n", "<leader>ci", ":TSToolsAddMissingImports<CR>",
          { desc = "[C]ode action add missing [I]mports", buffer = buffer })
        -- vim.lsp.inlay_hint.enable(true)
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        }
      }
    })

    require("fidget").setup({})
      -- zls = function()
      --   local lspconfig = require("lspconfig")
      --   lspconfig.zls.setup({
      --     root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
      --     settings = {
      --       zls = {
      --         enable_inlay_hints = true,
      --         enable_snippets = true,
      --         warn_style = true,
      --       },
      --     },
      --   })
      --   vim.g.zig_fmt_parse_errors = 0
      --   vim.g.zig_fmt_autosave = 0
      -- end,
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "rust_analyzer",
        "lua_ls",
        "gopls",
        "pyright",
        "solidity_ls_nomicfoundation",
      },
    })
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = {
            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
          }
        }
      }
    })
    vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            features = "all",
          },
          checkOnSave = {
            enable = true,
          },
          check = {
            command = "clippy",
          },
          imports = {
            group = {
              enable = false,
            },
          },
          completion = {
            postfix = {
              enable = false,
            },
          },
        },
      },
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- config LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature_help" })
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })
  end

}
