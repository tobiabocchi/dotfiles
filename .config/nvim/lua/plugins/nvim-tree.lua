return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
	},
	opts = {},
}
