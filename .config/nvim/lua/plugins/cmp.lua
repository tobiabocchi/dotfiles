return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-path",
		"micangl/cmp-vimtex",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"zbirenbaum/copilot-cmp",
	},
	config = function()
		require("copilot_cmp").setup()
		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp = require("cmp")
		local ls = require("luasnip")
		-- Configuer cmp
		cmp.setup({
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				-- Select the [n]ext item
				["<C-n>"] = cmp.mapping.select_next_item(),
				-- Select the [p]revious item
				["<C-p>"] = cmp.mapping.select_prev_item(),
				-- Accept ([y]es) the completion.
				--  This will auto-import if your LSP supports it.
				--  This will expand snippets if the LSP sent a snippet.
				["<C-y>"] = cmp.mapping.confirm({ select = true }),

				-- Manually trigger a completion from nvim-cmp.
				--  Generally you don't need this, because nvim-cmp will display
				--  completions whenever it has completion options available.
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-f>"] = cmp.mapping.scroll_docs(-4),
				["<C-v>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<C-l>"] = cmp.mapping(function()
					if ls.expand_or_locally_jumpable() then
						ls.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if ls.locally_jumpable(-1) then
						ls.jump(-1)
					end
				end, { "i", "s" }),
			}),
			experimental = {
				ghost_text = true,
			},
			-- sources for autocompletion
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "copilot" },
				{ name = "cmdline" },
				{ name = "vimtex" },
				{ name = "nvim_lsp_signature_help" },
			},
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true,
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
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
