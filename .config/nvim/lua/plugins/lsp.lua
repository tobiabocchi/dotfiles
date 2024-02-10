return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("neodev").setup({})
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				lspconfig[server_name].setup({})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			-- ["rust_analyzer"] = function ()
			--     require("rust-tools").setup {}
			-- end
		})
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				-- opts.desc = "Show signature help"
				-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				opts.desc = "Add workspace folder"
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				opts.desc = "Remove workspace folder"
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				opts.desc = "List workspace folders"
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				opts.desc = "Go to type definition"
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				opts.desc = "Rename"
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				opts.desc = "Show code actions"
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				opts.desc = "Show references"
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				--opts.desc = "Format"
				--vim.keymap.set("n", "<space>f", function()
				--	vim.lsp.buf.format({ async = true })
				--end, opts)
			end,
		})
		lspconfig.arduino_language_server.setup({
			cmd = {
				"/Users/tobiabocchi/.local/share/nvim/mason/bin/arduino-language-server",
				"-cli",
				"/opt/homebrew/bin/arduino-cli",
				"-cli-config",
				"/Users/tobiabocchi/Library/Arduino15/arduino-cli.yaml",
				"-clangd",
				"/Users/tobiabocchi/.local/share/nvim/mason/bin/clangd",
				"-fqbn",
				"esp32:esp32:esp32", -- "arduino:avr:uno",
				"-log",
				"-logpath",
				"/tmp/ardlsp",
				--"esp32:esp32:esp32",
				--"-fqbn", "arduino:avr:nano",
				-- TODO: consider setting fqbn based on project's location
			},
		})
	end,
}
--[=====[
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local opts = { noremap = true, silent = true }
		set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)             -- show definition, references
		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                         -- go to declaration
		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)            -- show lsp definitions
		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)        -- show lsp implementations
		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)       -- show lsp type definitions
		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)        -- see available code actions, in visual mode will apply to selection
		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)                      -- smart rename
		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)                -- show diagnostics for line
		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                        -- jump to previous diagnostic in buffer
		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                        -- jump to next diagnostic in buffer
		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)                                -- show documentation for what is under cursor
		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)                       -- mapping to restart lsp if necessary

		ocal get_servers = mason_lspconfig.get_installed_servers
		used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		for _, server_name in ipairs(get_servers()) do
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end

		configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
 --]=====]
