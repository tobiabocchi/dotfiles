return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	keys = {
		{ "<Leader>gg", "<cmd>Neogit<cr>", desc = "Launch Neo[G]it" },
	},
	opts = {},
}
