return {
	"zbirenbaum/copilot.lua",
	dependencies = { "copilotlsp-nvim/copilot-lsp" },
	event = { "InsertEnter" },
	opts = {
		panel = { enabled = false },
		suggestion = { enabled = false },
		filetypes = { markdown = false },
		nes = {
			enabled = true,
			keymap = {
				accept_and_goto = "<leader>p",
				accept = false,
				dismiss = "<Esc>",
			},
		},
	},
}
