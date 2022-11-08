require('telescope').setup{
  defaults = { file_ignore_patterns = {"node_modules", ".git", "vendor"} } }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<A-p>', builtin.live_grep, {})
--vim.keymap.set('n', '', builtin.buffers, {})
--vim.keymap.set('n', '', builtin.help_tags, {})
