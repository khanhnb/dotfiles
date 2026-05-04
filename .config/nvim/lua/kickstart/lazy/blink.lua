return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},
			opts = {},
		},
		"folke/lazydev.nvim",
		-- add blink.compat
		{
			"saghen/blink.compat",
			-- use v2.* for blink.cmp v1.*
			version = "2.*",
			-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
			lazy = true,
			-- make sure to set opts so that lazy.nvim calls blink.compat's setup
			opts = {},
		},
		{
			"supermaven-inc/supermaven-nvim",
			-- dependencies = { "huijiro/blink-cmp-supermaven" },
			opts = {
				-- disable_inline_completion = true, -- disables inline completion for use with cmp
				-- disable_keymaps = false,
				keymaps = {
					accept_suggestion = nil,
					-- clear_suggestion = "<C-]>",
					-- accept_word = "<C-j>",
				},
			},
		},
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		-- keymap = {
		--   preset = "default",
		-- },

		-- appearance = {
		--   nerd_font_variant = "mono",
		-- },

		completion = {
			-- list = {
			--   selection = {
			--     preselect = function(ctx)
			--       -- only preselect if no ghost_text available
			--       return true
			--     end,
			--   },
			-- },
			-- ghost_text = {
			--   enabled = true,
			--   show_with_menu = false,
			-- },
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
			menu = {
				-- auto_show = false,
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind" } },
				},
			},
		},

		sources = {
			default = { "lsp", "supermaven", "path", "snippets", "lazydev" },
			-- default = { 'lsp', 'path', 'snippets', 'lazydev' },
			providers = {
				lsp = { score_offset = 2 },
				snippets = {
					score_offset = 3,
					should_show_items = function(ctx)
						return ctx.trigger.initial_kind ~= "trigger_character"
					end,
				},
				path = { score_offset = 3 },
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				supermaven = {
					score_offset = 1,
					name = "supermaven",
					module = "blink.compat.source",
					-- module = "blink-cmp-supermaven",
					async = true,
				},
			},
		},

		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "lua" },
		signature = { enabled = true },
	},
}
