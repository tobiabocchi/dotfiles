-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy, import plugins from plugins folder and plugins/lsp
require("lazy").setup({
	-- Plugins with a single line can be added here, where more configuration is
	-- needed, plugins should be added in the plugins folder and imported here
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- "gc" to comment visual regions/lines
	{ import = "plugins" },
}, { -- more configuration options here https://github.com/folke/lazy.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
	checker = { enabled = true },
})
