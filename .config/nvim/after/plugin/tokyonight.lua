local success, tokyonight = pcall(require, 'tokyonight')
if not success then
    return
end
tokyonight.setup({
  style = "night",
  transparent = true,
})

vim.cmd("colorscheme tokyonight-night")
