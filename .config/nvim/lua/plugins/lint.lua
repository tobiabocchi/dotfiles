return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter" },
	config = function()
		local lint = require("lint")
		-- set linters per filetype
		lint.linters_by_ft = {
			ansible = { "ansible_lint" },
			bash = { "shellcheck" },
			cpp = { "cppcheck" },
			javascript = { "standardjs" },
			-- TODO: look into quick-lint-js
			markdown = { "markdownlint" },
			python = { "pylint" },
			yaml = { "yamllint" },
		}
		-- Addiional linter config
		lint.linters.yamllint.args = {
			'-d "rules: {indentation: {indent-sequences: consistent}}"',
		}
		-- TODO: check wether the augroup is needed
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
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
