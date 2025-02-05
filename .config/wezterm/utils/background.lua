local M = {}
local h = require("utils/helpers")

M.get_background = function()
  return {
    source = {
      Gradient = {
        -- default mocha and latte backgound colors
        -- colors = { h.is_dark() and "#1e1e2e" or "#eff1f5" },
        -- colors = { h.is_dark() and "#1e2323" or "#eff1f5" },
        -- colors = { h.is_dark() and "#111111" or "#eff1f5" },
        -- colors = { h.is_dark() and "#000000" or "#eff1f5" },
        colors = { "#000000" },
      },
    },
    width = "100%",
    height = "100%",
    -- opacity = h.is_dark() and 0.8 or 1,
    opacity = 1,
  }
end

return M
