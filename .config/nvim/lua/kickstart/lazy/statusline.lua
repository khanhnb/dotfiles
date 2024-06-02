return {
  {
    "tjdevries/express_line.nvim",
    config = function()
      local builtin = require "el.builtin"
      local extensions = require "el.extensions"
      local subscribe = require "el.subscribe"
      local sections = require "el.sections"
      local function set_hl(hls, s)
        if not hls or not s then
          return s
        end
        hls = type(hls) == "string" and { hls } or hls
        for _, hl in ipairs(hls) do
          if vim.fn.hlID(hl) > 0 then
            return ("%%#%s#%s%%0*"):format(hl, s)
          end
        end
        return s
      end

      local function diagnostics(_, buffer)
        local counts = { 0, 0, 0, 0 }
        local diags = vim.diagnostic.get(buffer.bufnr)
        if diags and not vim.tbl_isempty(diags) then
          for _, d in ipairs(diags) do
            if tonumber(d.severity) then
              counts[d.severity] = counts[d.severity] + 1
            end
          end
        end
        counts = {
          errors = counts[1],
          warnings = counts[2],
          infos = counts[3],
          hints = counts[4],
        }
        local items = {}
        local icons = {
          ["errors"] = { "E", "DiagnosticError" },
          ["warnings"] = { "W", "DiagnosticWarn" },
          ["infos"] = { "I", "DiagnosticInfo" },
          ["hints"] = { "H", "DiagnosticHint" },
        }
        for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
          if counts[k] > 0 then
            table.insert(items, set_hl(icons[k][2], ("%s%s"):format(icons[k][1], counts[k])))
          end
        end
        local fmt = " %s"
        if vim.tbl_isempty(items) then
          return ""
        end
        local contents = ("%s"):format(table.concat(items, " "))
        return fmt:format(contents)
      end
      require("el").setup({
        generator = function()
          local segments = {}

          table.insert(segments, extensions.mode)
          table.insert(segments, " ")
          table.insert(
            segments,
            subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
              local branch = extensions.git_branch(win, buf)
              if branch then
                return branch
              end
            end)
          )
          table.insert(
            segments,
            subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
              local changes = extensions.git_changes(win, buf)
              if changes then
                return changes
              end
            end)
          )
          table.insert(segments, subscribe.buf_autocmd("el_buf_diagnostic", "DiagnosticChanged", diagnostics))
          table.insert(segments, sections.split)
          table.insert(segments, "%f")
          table.insert(segments, sections.collapse_builtin({ { " " }, { builtin.modified_flag } }))
          table.insert(segments, sections.split)
          table.insert(segments, builtin.filetype)
          table.insert(segments, "[")
          table.insert(segments, builtin.line_with_width(3))
          table.insert(segments, ":")
          table.insert(segments, builtin.column_with_width(2))
          table.insert(segments, "]")

          return segments
        end,
      })
    end,
  },
}
