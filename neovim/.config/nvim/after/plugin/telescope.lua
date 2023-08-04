local telescope = require('telescope')
telescope.setup {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  -- file_ignore_patterns = {
  --   "node%_modules/.*",
  --   ".git/.*",
  -- },
  defaults = {
    file_ignore_patterns = { "^./.git/", "^node_modules/" },
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>gf', builtin.live_grep, {})
vim.keymap.set('n', '<leader> ', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

