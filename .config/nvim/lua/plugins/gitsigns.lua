return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	keys = {
		{ "<Leader>gs", "<cmd>Gitsigns refresh<cr>", desc = "Launch [G]it [S]igns" },
		{ "<Leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "[G]it preview [H]unk" },
		{ "<Leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "[G]it [D]iff" },
		{ "<Leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "[G]it toggle line [B]lame" },
	},
	opts = {},
	--TODO: add navigation shortcut
	--
	-- map('n', ']c', function()
	--   if vim.wo.diff then
	--     vim.cmd.normal({']c', bang = true})
	--   else
	--     gitsigns.nav_hunk('next')
	--   end
	-- end)
	--
	-- map('n', '[c', function()
	--   if vim.wo.diff then
	--     vim.cmd.normal({'[c', bang = true})
	--   else
	--     gitsigns.nav_hunk('prev')
	--   end
	-- end)
}
