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
-- local h = require("utils/helpers")
-- local k = require("utils/keys")
local w = require("utils/wallpaper")

local wezterm = require("wezterm")
-- local act = wezterm.action

wezterm.time.call_after(600, function()
	wezterm.reload_configuration()
end)

local config = {
	-- background
	background = {
		w.get_wallpaper(),
		b.get_background(),
	},

	-- font
	font = f.get_font(),
	font_size = 16,

	-- colors
	color_scheme = cs.get_color_scheme(),

	-- padding
	window_padding = {
		left = 20,
		right = 20,
		top = 10,
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
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	-- default_cursor_style = "BlinkingBlock",

	-- keys
	keys = {
		-- CTRL-SHIFT-l activates the debug overlay
		{ key = 'D', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
		{ key = 'L', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment, },
		{ key = 'K', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment, },
		{ key = 'H', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment, },
	},
}

return config
