-- install without yarn or npm
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	keys = {
		{ "<Leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Launch [M]arkdown [P]review" },
	},
	config = function()
		vim.g.mkdp_browser = "safari"
	end,
	ft = { "markdown" },
	-- build = "cd app && yarn install",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
