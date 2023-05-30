-- Configure the plugin only if it's installed
local success, ts = pcall(require, "nvim-treesitter.configs")
if not success then
	return
end

ts.setup({
	ensure_installed = { "help", "python", "lua", "bash", "html" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "latex" },
		additional_vim_regex_highlighting = false,
	},
})
