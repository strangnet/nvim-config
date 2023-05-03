vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

require("nvim-tree").setup({
  disable_netrw = false,
  view = {
    adaptive_size = true
  },
})

vim.keymap.set('n', '<leader>ft', ':NvimTreeFindFileToggle<CR>')

