return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local open_with_trouble = require("trouble.sources.telescope").open
    require("telescope").setup({
      defaults = {
        mappings = {
          n = { ["<C-q>"] = open_with_trouble },
          i = { ["<C-q>"] = open_with_trouble }
        }
      },
      pickers = {
        git_files = {
          -- theme = "dropdown",
          theme = "ivy",
          layout_config = {
            height = 10,
          },
        },
      },
      extensions = {
        fzf = {}
      }
    })

    require("telescope").load_extension("fzf")

    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == "" then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ":h")
      end

      -- Find the Git root directory from the current file's path
      local git_root =
          vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
      if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
      end
      -- print('Searching on git root: %s', git_root)
      return git_root
    end
    local function live_grep_git_root()
      local git_root = find_git_root()
      if git_root then
        require("telescope.builtin").live_grep({
          search_dirs = { git_root },
          file_ignore_patterns = { ".git/", "node_modules" },
          additional_args = function(opts)
            return { "--hidden" }
          end,
        })
      end
    end

    local function grep_string_git_root()
      local git_root = find_git_root()
      if git_root then
        require("telescope.builtin").grep_string({
          search_dirs = { git_root },
          search = vim.fn.input("Grep > "),
          file_ignore_patterns = { ".git/", "node_modules" },
          additional_args = function(opts)
            return { "--hidden" }
          end,
        })
      end
    end

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sF", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sf", builtin.git_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    -- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", live_grep_git_root, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        -- winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
    -- builtin.grep_string({ search = vim.fn.input("Grep > ") })
    vim.keymap.set('n', '<leader>sw', grep_string_git_root)
    -- might need it later
    vim.keymap.set('n', '<leader>sc', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({
        search = word,
        search_dirs = { find_git_root() },
        file_ignore_patterns = { ".git/", "node_modules" },
        additional_args = function(opts)
          return { "--hidden" }
        end,
      })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    -- search all nvim packages
    -- vim.keymap.set('n', '<leader>sp', function()
    --   require('telescope.builtin').find_files({
    --     prompt_title = '[S]earch Neovim [P]ackages',
    --     cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
    --   })
    -- end)
    -- advanced search
    require('kickstart.custom.multigrep').setup()
  end

}
