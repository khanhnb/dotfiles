return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    {
      "zbirenbaum/copilot-cmp",
      dependencies = "copilot.lua",
      opts = {
        event = { "InsertEnter", "LspAttach" },
        fix_pairs = true,
      },
    },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    }
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "ts_ls"
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
        ["ts_ls"] = function()
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
        end
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        -- sorry, Ctrl-y is a little hard to press
        -- press enter to confirm, and dont auto select the first item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      -- Cmp menu width varies greatly when using Rust
      -- https://github.com/hrsh7th/nvim-cmp/issues/1154
      formatting = {
        format = function(entry, vim_item)
          local m = vim_item.menu and vim_item.menu or ""
          if #m > 20 then
            vim_item.menu = string.sub(m, 1, 20) .. "..."
          end
          return vim_item
          -- vim_item.menu = nil
          -- return vim_item
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' },
        { name = 'copilot' },
      }, {
        { name = 'buffer' },
      })
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
