return {
	{
		"catppuccin/nvim",
		name = "catpuccin",
		priority = 1000,
		config = function()
			local colorscheme = require("catppuccin")
			colorscheme.setup({
				transparent_background = true,
			})
			-- set colorscheme
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
