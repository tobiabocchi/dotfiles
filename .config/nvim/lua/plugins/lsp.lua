return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre" },
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				vim.lsp.enable(server_name)
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			-- ["rust_analyzer"] = function ()
			--     require("rust-tools").setup {}
			-- end
		})
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(event)
				-- helper_fn: sets the mode, buffer and description
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  To jump back, press <C-T>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})
		-- Ad-Hoc LSP server configurations
		-- vim.lsp.config('arduino_language_server', {})
		-- lspconfig.arduino_language_server.setup({
		-- 	cmd = {
		-- 		"/Users/tobiabocchi/.local/share/nvim/mason/bin/arduino-language-server",
		-- 		"-cli",
		-- 		"/opt/homebrew/bin/arduino-cli",
		-- 		"-cli-config",
		-- 		"/Users/tobiabocchi/Library/Arduino15/arduino-cli.yaml",
		-- 		"-clangd",
		-- 		"/Users/tobiabocchi/.local/share/nvim/mason/bin/clangd",
		-- 		"-fqbn",
		-- 		"arduino:avr:uno", -- "esp32:esp32:esp32",
		-- 		-- "-log",
		-- 		-- "-logpath",
		-- 		-- "/tmp/ardlsp",
		-- 		-- TODO: consider setting fqbn based on project's location
		-- 	},
		-- })
		-- lspconfig.yamlls.setup({
		-- 	settings = {
		-- 		yaml = {
		-- 			-- manually select schemas
		-- 			schemas = {
		-- 				kubernetes = "*.yaml",
		-- 				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28-standalone-strict/all.json"] = "/*.k8s.yaml",
		-- 				["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
		-- 				["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
		-- 				["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.yaml",
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- lspconfig.lua_ls.setup({
		-- 	-- cmd = {...},
		-- 	-- filetypes { ...},
		-- 	-- capabilities = {},
		-- 	settings = {
		-- 		Lua = {
		-- 			runtime = { version = "LuaJIT" },
		-- 			workspace = {
		-- 				checkThirdParty = false,
		-- 				-- Tells lua_ls where to find all the Lua files that you have loaded
		-- 				-- for your neovim configuration.
		-- 				library = {
		-- 					"${3rd}/luv/library",
		-- 					unpack(vim.api.nvim_get_runtime_file("", true)),
		-- 				},
		-- 				-- If lua_ls is really slow on your computer, you can try this instead:
		-- 				-- library = { vim.env.VIMRUNTIME },
		-- 			},
		-- 			completion = {
		-- 				callSnippet = "Replace",
		-- 			},
		-- 			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
		-- 			-- diagnostics = { disable = { 'missing-fields' } },
		-- 		},
		-- 	},
		-- })
	end,
}
