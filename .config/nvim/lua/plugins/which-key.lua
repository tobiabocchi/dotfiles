return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		-- require("which-key").register({
		-- 	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
		-- 	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
		-- 	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
		-- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
		-- 	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
		-- })
		require("which-key").add({
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
		})
	end,
}
