return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/syncthing/tobiabocchi/vaults/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/syncthing/tobiabocchi/vaults/**.md",
	},
	keys = {
		{ "<Leader>od", "<cmd>Obsidian today<cr>", desc = "[O]bsidian [D]aily note" },
		{ "<Leader>oe", "<cmd>Obsidian extract_note<cr>", desc = "[O]bsidian [E]xtract note", mode = "v" },
		{ "<Leader>ol", "<cmd>Obsidian link_new<cr>", desc = "Create new [L]ink with visual selection", mode = "v" },
		{ "<Leader>on", "<cmd>Obsidian new<cr>", desc = "[O]bsidian [N]ew note" },
		{ "<Leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "[O]bsidian [Q]uick Switch" },
		{ "<Leader>os", "<cmd>Obsidian search<cr>", desc = "[O]bsidian [S]earch" },
		{ "<Leader>ot", "<cmd>Obsidian toc<cr>", desc = "[O]bsidian [T]oc" },
		{ "<Leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "[O]bsidian [Y]esterday note" },
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "para",
				path = "~/syncthing/tobiabocchi/vaults/para",
			},
		},
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "dailies",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = "daily.md",
		},
		ui = { enable = false },
		new_notes_location = vim.fn.expand("~") .. "/syncthing/tobiabocchi/vaults/para/new",
		-- Optional, for templates (see below).
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
		},
	},
}
