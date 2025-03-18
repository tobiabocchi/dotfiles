return {
	"epwalsh/obsidian.nvim",
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
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<Leader>os", "<cmd>ObsidianSearch<cr>", desc = "[O]bsidian [S]earch" },
		{ "<Leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "[O]bsidian [Q]uick Switch" },
		{ "<Leader>on", "<cmd>ObsidianNew<cr>", desc = "[O]bsidian [N]ew note" },
		{ "<Leader>od", "<cmd>ObsidianToday<cr>", desc = "[O]bsidian [D]aily note" },
		{ "<Leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "[O]bsidian [Y]esterday note" },
		{ "<Leader>ot", "<cmd>ObsidianTOC<cr>", desc = "[O]bsidian [T]oc" },
		{ "<Leader>l", "<cmd>ObsidianLinkNew<cr>", desc = "Create new [L]ink with visual selection", mode = "v" },
	},
	opts = {
		workspaces = {
			{
				name = "para",
				path = "~/syncthing/tobiabocchi/vaults/para",
				overrides = {
					notes_subdir = "new",
				},
			},
		},
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			min_chars = 2,
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
		-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
		new_notes_location = vim.fn.expand("~") .. "/syncthing/tobiabocchi/vaults/para/new",
		-- Optional, for templates (see below).
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.date("%Y%m%d%H%M%S")) .. "-" .. suffix
		end,

		-- Optional, customize how note file names are generated given the ID, target directory, and title.
		---@param spec { id: string, dir: obsidian.Path, title: string|? }
		---@return string|obsidian.Path The full path to the new note.
		note_path_func = function(spec)
			-- This is equivalent to the default behavior.
			local path = spec.dir / tostring(spec.id)
			return path:with_suffix(".md")
		end,
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},
	},
}
