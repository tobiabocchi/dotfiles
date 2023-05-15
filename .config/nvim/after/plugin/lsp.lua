-----------------------
--        TOC        --
-----------------------
-- 1. Luasnip
-- 2. The completion engine
-- 3. Mason
-- 4. lspconfig
-- 5. null-ls
-- 6. copilot

local success, cmp, luasnip, lspkind, mason, copilot_cmp
success, cmp = pcall(require, "cmp")
if not success then
	return
end
success, luasnip = pcall(require, "luasnip")
if not success then
	return
end
success, lspkind = pcall(require, "lspkind")
if not success then
	return
end
success, mason = pcall(require, "mason")
if not success then
	return
end

------------------------------
--        1. Luasnip        --
------------------------------

-- extend some filetypes for additional snippets
-- ls.filetype_extend("python", {"django"})
-- ls.filetype_extend("htmldjango", {"html"})
-- ls.filetype_extend("html", {"ejs"})
-- ls.filetype_extend("javascript", {"javascriptreact"})
-- load some default snippets from luasnip
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/tobiabocchi/.local/share/nvim/snippets/jinja2-kit-vscode" }}) -- load jinja snippets
require("luasnip.loaders.from_vscode").lazy_load()

------------------------------
-- 2. The completion engine --
------------------------------

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- for docs within completion window
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-v>"] = cmp.mapping.scroll_docs(4),
		-- trigger/abort/accept completion
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	experimental = {
		ghost_text = true, -- this feature conflict with copilot.vim's preview.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" }, -- nvim api completion
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "copilot" },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			symbol_map = { Copilot = "" },
		}),
	},
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

------------------------------
--        3. Mason          --
------------------------------
mason.setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"pylsp",
		"bashls",
		"arduino_language_server",
		"lua_ls",
		"html",
	},
})

------------------------------
--        4. lspconfig      --
------------------------------
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
local lsp_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

local get_servers = require("mason-lspconfig").get_installed_servers
local lspconfig = require("lspconfig")

for _, server_name in ipairs(get_servers()) do
	lspconfig[server_name].setup({
		on_attach = lsp_attach,
		capabilities = lsp_capabilities,
	})
end

-- Servers that require specific configuration:

lspconfig.arduino_language_server.setup({
	on_attach = lsp_attach,
	cmd = {
		"/Users/tobiabocchi/.local/share/nvim/mason/bin/arduino-language-server",
		"-cli",
		"/opt/homebrew/bin/arduino-cli",
		"-cli-config",
		"/Users/tobiabocchi/Library/Arduino15/arduino-cli.yaml",
		"-clangd",
		"/Users/tobiabocchi/.local/share/nvim/mason/bin/clangd",
		"-fqbn",
		"arduino:avr:uno",
		"-log",
		"-logpath",
		"/tmp/ardlsp",
		--"esp32:esp32:esp32",
		--"-fqbn", "arduino:avr:nano",
		-- TODO: consider setting fqbn based on project's location
	},
})

lspconfig.lua_ls.setup({
	on_attach = lsp_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

------------------------------
--        5. null-ls        --
------------------------------
local null_ls = require("null-ls")

-- Find more here: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
	sources = {
		-- Formatters:
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		-- Linters:
		null_ls.builtins.diagnostics.markdownlint,
	},
})
