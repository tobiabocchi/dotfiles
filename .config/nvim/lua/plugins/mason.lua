return {
	"williamboman/mason.nvim",
	event = { "CmdlineEnter" },
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	keys = {
		{ "<Leader>m", "<cmd>Mason<cr>", desc = "Open Mason" },
	},
	config = function()
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters, check format.lua
				"black", -- [F] python
				"isort", -- [F] python
				"prettierd", -- [F] js css html and more
				"shfmt", -- [F] shell
				"stylua", -- [F] lua
				"clang-format", -- [F] c and c++
				-- Linters, check lint.lua
				"standardjs", -- [L] js
				"markdownlint", -- [L] markdown, also formatter
				"pylint", -- [L] python
				"shellcheck", -- [L] shell
				"yamllint", -- [L] YAML
				-- "harper-ls", -- [L] grammar check
				-- Language servers, check lsp.lua
				"arduino-language-server", -- [LSP] arduino
				"bash-language-server", -- [LSP] bash
				"clangd", -- [LSP] c c++
				"gopls", -- [LSP] go
				"html-lsp", -- [LSP] html
				"lua-language-server", -- [LSP] lua
				"pyright", -- [LSP] python
				"rust-analyzer", -- [LSP] rust
				"terraform-ls", -- [LSP] terraform
				"vale-ls", -- [LSP] markdown
				"yaml-language-server", -- [LSP] YAML
				-- Debuggers
				"cpptools", -- [DAP] c++
			},
		})
	end,
}
