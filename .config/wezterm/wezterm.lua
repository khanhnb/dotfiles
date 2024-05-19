--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local b = require("utils/background")
local cs = require("utils/color_scheme")
local f = require("utils/font")
local w = require("utils/wallpaper")

local wezterm = require("wezterm")
local act = wezterm.action

-- wezterm.time.call_after(3600, function()
-- 	wezterm.reload_configuration()
-- end)

local config = {
	-- background
	background = {
		-- w.get_wallpaper(),
		b.get_background(),
	},

	-- colors
	-- transparent tab_bar
	colors = {
		tab_bar = {
			background = 'rgba(0,0,0,0)'
		}
	},

	-- font
	font = f.get_font(),
	font_size = 16,
	line_height = 1.2,

	-- colors
	color_scheme = cs.get_color_scheme(),

	-- padding
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},

	-- set_environment_variables = {
	-- 	-- THEME_FLAVOUR = "latte",
	-- 	BAT_THEME = h.is_dark() and "Catppuccin-mocha" or "Catppuccin-latte",
	-- },

	-- general options
	-- disable_default_key_bindings = true,
	adjust_window_size_when_changing_font_size = false,
	debug_key_events = false,
	enable_tab_bar = true,
	tab_bar_at_bottom = false,
	use_fancy_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	-- window_decorations = "TITLE",
	default_cursor_style = "SteadyBlock",

	-- keys
	keys = {
		-- CTRL-SHIFT-l activates the debug overlay
		{ key = "D", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
		{ key = "L", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
		{ key = "K", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
		{ key = "H", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
		{
			key = 'E',
			mods = 'SUPER|SHIFT',
			action = act.PromptInputLine {
				description = 'Enter new name for tab',
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			},
		},
	},
}

return config
