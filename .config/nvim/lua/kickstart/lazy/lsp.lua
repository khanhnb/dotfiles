return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jose-elias-alvarez/typescript.nvim",

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    -- { "j-hui/fidget.nvim",       opts = { notification = { window = { winblend = 0 } } } },
    { "j-hui/fidget.nvim",       opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gd", function()
          require("trouble").toggle("lsp_definitions")
        end, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        -- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gr", function()
          require("trouble").toggle("lsp_references")
        end, "[G]oto [R]eferences")

        -- signature help
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature_help" })

        -- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gI", function()
          require("trouble").toggle("lsp_implementations")
        end, "[G]oto [I]mplementation")

        -- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>D", function()
          require("trouble").toggle("lsp_type_definitions")
        end, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map(
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "[W]orkspace [S]ymbols"
        )

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header
        -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      clangd = {},
      gopls = {},
      jdtls = {},
      rust_analyzer = {},
      tsserver = {},

      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format lua code
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          -- print("Setup " .. server_name .. " with config: ", vim.inspect(server.settings))
          if (server_name == "tsserver") then
            require("typescript").setup({
              server = { -- pass options to lspconfig's setup method
                on_attach = function(_, buffer)
                  print("setup keymap for typescript")
                  vim.keymap.set("n", "<leader>co", ":TypescriptOrganizeImports<CR>",
                    { buffer = buffer, desc = "[C]ode action [O]rganize imports" })
                  vim.keymap.set("n", "<leader>cr", ":TypescriptRemoveUnused<CR>",
                    { buffer = buffer, desc = "[C]ode action [R]emove unused" })
                  vim.keymap.set("n", "<leader>cf", ":TypescriptFixAll<CR>",
                    { buffer = buffer, desc = "[C]ode action [F]ix all" })
                  vim.keymap.set("n", "<leader>cR", ":TypescriptRenameFile<CR>",
                    { desc = "[C]ode action [R]ename File", buffer = buffer })
                  vim.keymap.set("n", "gD", ":TypescriptGoToSourceDefinition<CR>",
                    { desc = "[G]o to source [D]efinition", buffer = buffer })
                  vim.keymap.set("n", "<leader>ci", ":TypescriptAddMissingImports<CR>",
                    { desc = "[C]ode action add missing [I]mports", buffer = buffer })
                  vim.lsp.inlay_hint.enable(true)
                end,
                settings = {
                  -- specify some or all of the following settings if you want to adjust the default behavior
                  javascript = {
                    inlayHints = {
                      includeInlayEnumMemberValueHints = true,
                      includeInlayFunctionLikeReturnTypeHints = true,
                      includeInlayFunctionParameterTypeHints = true,
                      includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                      includeInlayPropertyDeclarationTypeHints = true,
                      includeInlayVariableTypeHints = true,
                    },
                  },
                  typescript = {
                    inlayHints = {
                      includeInlayEnumMemberValueHints = true,
                      includeInlayFunctionLikeReturnTypeHints = true,
                      includeInlayFunctionParameterTypeHints = true,
                      includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                      includeInlayPropertyDeclarationTypeHints = true,
                      includeInlayVariableTypeHints = true,
                    },
                  },
                },
              },
              disable_commands = false, -- prevent the plugin from creating Vim commands
              debug = false,            -- enable debug logging for commands
              go_to_source_definition = {
                fallback = true,        -- fall back to standard LSP definition on failure
              },
            })
          else
            require("lspconfig")[server_name].setup(server)
          end
        end,
      },
    })
  end,
}
