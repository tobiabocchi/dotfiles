return {
	"stevearc/conform.nvim",
	event = { "BufReadPre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format entire buffer or range in visual mode",
		},
	},
	opts = {
		-- Define your formatters, for info use autocomplete for :setfiletype
		formatters_by_ft = {
			bash = { "shfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			css = { "prettierd" },
			go = { "gopls" },
			html = { "stylua" },
			javascript = { "standardjs" },
			json = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			python = { "isort", "black" },
			sh = { "shfmt" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
			-- TODO: this is not working
			clang_format = {
				prepend_args = { "--fallback-style", "Google" },
				-- args = { "-assume-filename", "$FILENAME" },
			},
		},
	},
	init = function()
		-- Conform also provides a formatexpr, same as the LSP client:
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
