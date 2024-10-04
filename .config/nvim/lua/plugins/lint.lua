return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter" },
	config = function()
		local lint = require("lint")
		-- set linters per filetype
		lint.linters_by_ft = {
			bash = { "shellcheck" },
			cpp = { "cppcheck" },
			javascript = { "standardjs" },
			-- look into quick-lint-js
			markdown = { "markdownlint" },
			python = { "pylint" },
			yaml = { "yamllint" },
		}
		local pattern = "[^:]+:(%d+):(%d+):([^%.]+%.?)%s%(([%a-]+)%)%s?%(?(%a*)%)?"
		local groups = { "lnum", "col", "message", "code", "severity" }
		local severities = {
			[""] = vim.diagnostic.severity.ERROR,
			["warning"] = vim.diagnostic.severity.WARN,
		}
		-- TODO: check wether the augroup is needed
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				local filepath = vim.fn.expand("%:p")
				if vim.fn.filereadable(filepath) ~= 0 then
					lint.try_lint()
				end
			end,
		})
	end,
}
