return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = { "c", "bash", "cpp", "css", "html", "lua", "markdown", "python", "vimdoc" },
		sync_install = false,
		auto_install = true,
		indent = { enable = true },
		highlight = {
			enable = true,
			disable = { "latex" },
			additional_vim_regex_highlighting = false,
			-- additional_vim_regex_highlighting = { "latex" },
		},
	},
}
