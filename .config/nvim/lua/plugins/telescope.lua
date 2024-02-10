return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "sf", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files" },
		{ "sg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "sh", "<cmd>Telescope help_tags<cr>", desc = "Fuzzy find h" },
	},
	config = true,
}
