return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "j-hui/fidget.nvim",
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
    "saghen/blink.cmp",
    "folke/lazydev.nvim",
  },

  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("typescript-tools").setup({
      on_attach = function(_, buffer)
        vim.keymap.set(
          "n",
          "<leader>co",
          ":TSToolsOrganizeImports<CR>",
          { buffer = buffer, desc = "[C]ode action [O]rganize imports" }
        )
        vim.keymap.set(
          "n",
          "<leader>cr",
          ":TSToolsRemoveUnused<CR>",
          { buffer = buffer, desc = "[C]ode action [R]emove unused" }
        )
        vim.keymap.set(
          "n",
          "<leader>cf",
          ":TSToolsFixAll<CR>",
          { buffer = buffer, desc = "[C]ode action [F]ix all" }
        )
        vim.keymap.set(
          "n",
          "<leader>cR",
          ":TSToolsRenameFile<CR>",
          { desc = "[C]ode action [R]ename File", buffer = buffer }
        )
        vim.keymap.set(
          "n",
          "gD",
          ":TSToolsGoToSourceDefinition<CR>",
          { desc = "[G]o to source [D]efinition", buffer = buffer }
        )
        vim.keymap.set(
          "n",
          "<leader>ci",
          ":TSToolsAddMissingImports<CR>",
          { desc = "[C]ode action add missing [I]mports", buffer = buffer }
        )
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
        },
      },
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
        -- "solidity_ls_nomicfoundation",
        "solidity_ls",
        "stylua",
      },
    })
    local servers = {
      stylua = {},
      -- lua_ls = {
      --   on_init = function(client)
      --     client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)
      --
      --     if client.workspace_folders then
      --       local path = client.workspace_folders[1].name
      --       if
      --           path ~= vim.fn.stdpath("config")
      --           and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      --       then
      --         return
      --       end
      --     end
      --
      --     client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      --       runtime = {
      --         version = "LuaJIT",
      --         path = { "lua/?.lua", "lua/?/init.lua" },
      --       },
      --       workspace = {
      --         checkThirdParty = false,
      --         -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
      --         --  See https://github.com/neovim/nvim-lspconfig/issues/3189
      --         library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
      --           "${3rd}/luv/library",
      --           "${3rd}/busted/library",
      --         }),
      --       },
      --     })
      --   end,
      --   ---@type lspconfig.settings.lua_ls
      --   settings = {
      --     Lua = {
      --       format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      --     },
      --   },
      -- },
      rust_analyzer = {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              features = "all",
              -- allFeatures = false,
            },
            checkOnSave = {
              enable = true,
            },
            -- cachePriming = { enable = false },
            check = {
              command = "clippy",
              -- extraArgs = { "--release" },
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
      },
      solidity_ls = {
        on_attach = function(_, buffer)
          vim.keymap.set(
            "n",
            "<leader>f",
            ":!forge fmt<CR>",
            { buffer = buffer, desc = "[F]ormat using forge fmt" }
          )
        end,
        -- root_dir = require("lspconfig.util").root_pattern("foundry.toml", ".git"),
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    -- manually trigger rust analyzer check
    ---@alias rustaceanvim.flyCheckCommand 'run' | 'clear' | 'cancel'

    ---@param cmd rustaceanvim.flyCheckCommand
    local function raFlycheck(cmd)
      local clients = vim.lsp.get_clients({
        name = "rust_analyzer",
      })
      for _, client in ipairs(clients) do
        local params = cmd == "run" and vim.lsp.util.make_text_document_params() or nil
        client:notify("rust-analyzer/" .. cmd .. "Flycheck", params)
      end
    end
    vim.keymap.set("n", "<leader>cc", function()
      raFlycheck("run")
    end, {})
    -- vim.keymap.set("n", "<leader>cc", function()
    --   raFlycheck("clear")
    -- end, {})

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = true,
        style = "minimal",
        source = "if_many",
        header = "",
        prefix = "",
      },
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
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
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
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
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })
  end,
}
