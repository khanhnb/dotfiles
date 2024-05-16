-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		opts = {
			event = { "InsertEnter", "LspAttach" },
			fix_pairs = true,
		},
	},
	{
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
	},
	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_WindowLayout = 2
		end,
	},
	{
		"nvim-treesitter/playground",
	},
	{
		"folke/trouble.nvim",
		opts = {
			-- settings without a patched font or icons
			icons = false,
			fold_open = "v",   -- icon used for open folds
			fold_closed = ">", -- icon used for closed folds
			indent_lines = false, -- add an indent guide below the fold icons
			signs = {
				-- icons / text used for a diagnostic
				error = "error",
				warning = "warn",
				hint = "hint",
				information = "info",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		},
	},
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			-- spawn additional tsserver instance to calculate diagnostics on it
	-- 			separate_diagnostic_server = true,
	-- 			-- "change"|"insert_leave" determine when the client asks the server about diagnostic
	-- 			publish_diagnostic_on = "insert_leave",
	-- 			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
	-- 			-- "remove_unused_imports"|"organize_imports") -- or string "all"
	-- 			-- to include all supported code actions
	-- 			-- specify commands exposed as code_actions
	-- 			expose_as_code_action = {},
	-- 			-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
	-- 			-- not exists then standard path resolution strategy is applied
	-- 			tsserver_path = nil,
	-- 			-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
	-- 			-- (see 💅 `styled-components` support section)
	-- 			tsserver_plugins = {},
	-- 			-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
	-- 			-- memory limit in megabytes or "auto"(basically no limit)
	-- 			tsserver_max_memory = "auto",
	-- 			-- described below
	-- 			tsserver_format_options = {},
	-- 			tsserver_file_preferences = {},
	-- 			-- locale of all tsserver messages, supported locales you can find here:
	-- 			-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
	-- 			tsserver_locale = "en",
	-- 			-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
	-- 			complete_function_calls = false,
	-- 			include_completions_with_insert_text = true,
	-- 			-- CodeLens
	-- 			-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
	-- 			-- possible values: ("off"|"all"|"implementations_only"|"references_only")
	-- 			code_lens = "off",
	-- 			-- by default code lenses are displayed on all referencable values and for some of you it can
	-- 			-- be too much this option reduce count of them by removing member references from lenses
	-- 			disable_member_code_lens = true,
	-- 			-- JSXCloseTag
	-- 			-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
	-- 			-- that maybe have a conflict if enable this feature. )
	-- 			jsx_close_tag = {
	-- 				enable = false,
	-- 				filetypes = { "javascriptreact", "typescriptreact" },
	-- 			},
	-- 		},
	-- 	},
	-- },
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},
	-- {
	-- 	"nvimdev/lspsaga.nvim",
	-- 	config = function()
	-- 		require("lspsaga").setup({
	-- 			ui = {
	-- 				-- scroll_down = "<C-d>",
	-- 				-- scroll_up = "<C-u>",
	-- 			},
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter", -- optional
	-- 		"nvim-tree/nvim-web-devicons",  -- optional
	-- 	},
	-- },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
				end,
			},
		},
	},
	{
		'stevearc/oil.nvim',
		opts = {
			columns = {
				-- "icon",
				-- "permissions",
				-- "size",
				-- "mtime"
			},
			view_options = {
				show_hidden = true,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	}
}
