vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("basic")
require("plugins")
require("mapping")

require("lsp/setup")
require('lsp/nvim-cmp')

require("auto-save").setup { trigger_events = {"InsertLeave"} }
require('lualine').setup {}
require("nvim-autopairs").setup {}
require('nvim-ts-autotag').setup {}
require('goto-preview').setup {}

require("null-ls").setup({
    sources = { },
})
require("trouble").setup {}

require("plugin_configs.treesitter")
require("plugin_configs.bufferline")
require("plugin_configs.telescope")


vim.cmd([[colorscheme gruvbox]])
vim.o.background = "light"


vim.g.floaterm_keymap_toggle = '<F12>'

