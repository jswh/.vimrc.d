vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

-- 窗口切换
map("n", "wh", "<C-w>h", opt)
map("n", "wj", "<C-w>j", opt)
map("n", "wk", "<C-w>k", opt)
map("n", "wl", "<C-w>l", opt)

-- nvim tree
map('n', 'dir', ':NERDTreeToggle<CR>', opt)
map('n', 'dif', ':NERDTreeFind<CR>', opt)

-- bufferline 左右Tab切换
map("n", "<A-[>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<A-]>", ":BufferLineCycleNext<CR>", opt)
-- 关闭当前buffer
map("n", "<A-x>", ":w | bp | bd #<CR>", opt)

local pluginKeys = {}

pluginKeys.maplsp = function(mapbuf)
  -- rename
  mapbuf('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf('n', 'gp', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gdd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  mapbuf('n', 'gd', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)

  mapbuf('n', '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)

  mapbuf('n', 'gp', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opt)
  -- mapbuf('n','gpt', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opt)
  -- mapbuf('n','gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opt)
  -- mapbuf('n','<leader>P',  "<cmd>lua require('goto-preview').close_all_win()<CR>", opt)
  -- mapbuf('n','gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opt)

end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {

    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),

    ['<A-.>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

    ['<A-,>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      select = true ,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  }
end

return pluginKeys


