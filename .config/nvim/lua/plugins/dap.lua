return {
	"mfussenegger/nvim-dap",
	cmd = { "DapContinue" },
	keys = {
		{ "<F5>", "<cmd>DapContinue<cr>", desc = "Continue execution" },
		{ "<Leader>s", "<cmd>DapStepOver<cr>", desc = "Step Over" },
		{ "<Leader>si", "<cmd>DapStepInto<cr>", desc = "Step Over" },
		{ "<Leader>so", "<cmd>DapStepOut<cr>", desc = "Step Over" },
		{ "<Leader>b", "<cmd>DapToggleBreakPoint<cr>", desc = "Step Over" },
		{
			"<Leader>lp",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set log point",
		},
		{ "<Leader>dr", "<cmd>DapToggleRepl<cr>", desc = "Toggle Repl" },
		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			mode = { "n", "v" },
			desc = "Spawn hover info",
		},
		{
			"<Leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			mode = { "n", "v" },
			desc = "Spawn widgets",
		},
		{
			"<Leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.sidebar(widgets.frames).open()
			end,
			desc = "Open frame",
		},
		{
			"<Leader>ds",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.sidebar(widgets.scopes).open()
			end,
			desc = "Open sidebar",
		},
	},
	config = function()
        -- setup debuggers here
		local dap = require("dap")
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				MIMode = "lldb",
				request = "launch",
				program = "main",
				cwd = "${workspaceFolder}",
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
				stopAtEntry = false,
			},
		}
	end,
}
