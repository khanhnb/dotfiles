local wezterm = require("wezterm")
local h = require("utils/helpers")
local M = {}

M.get_font = function()
	local fonts = {
		-- "JetBrainsMono Nerd Font",
		-- "FiraCode Nerd Font",
		"GeistMono Nerd Font",
	}
	local family = h.get_random_entry(fonts)
	return wezterm.font_with_fallback({
		{ family = family, weight = "Medium" },
		{ family = "JetBrains Mono", weight = "Medium" },
	})
end

return M
