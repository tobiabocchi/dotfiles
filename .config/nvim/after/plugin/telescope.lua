-- Configure the plugin only if it's installed
local success, telescope = pcall(require, 'telescope')
if not success then
    return
end

telescope.setup{
    defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
  },
  extensions = {
  }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'sf', builtin.find_files, {})
vim.keymap.set('n', 'sg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', 'sh', builtin.help_tags, {})
