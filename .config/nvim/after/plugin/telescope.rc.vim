if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> ;f <cmd>Telescope git_files path_display={"smart"}<cr>
nnoremap  <silent> ;r <cmd>Telescope live_grep path_display={"smart"}  <cr>
nnoremap <silent> \\ <cmd>telescope buffers<cr>
nnoremap <silent> ;; <cmd>telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

