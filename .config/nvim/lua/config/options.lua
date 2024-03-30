-- Search
-- vim.opt.hlsearch = false -- don't highlight search pattern
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if upper case in search pattern

-- General options
vim.opt.autowrite = true
vim.opt.swapfile = false -- don't use swap file
vim.opt.mouse = "a"
-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- undo management
local undodir_path = vim.env.HOME .. "/.local/share/nvim/undodir"
if vim.fn.isdirectory(undodir_path) == 0 then -- dir doesn't exist, create it
	print("Undo directory doesn't exist, creating it")
	vim.fn.mkdir(undodir_path, "p")
	-- TODO: look into dir permission, 700?
	-- mkdir($HOME .. "/tmp/foo/bar", "p", 0o700)
end
vim.opt.undofile = true
vim.opt.undodir = undodir_path

-- Tab handling
vim.opt.expandtab = true -- insert spaces instead of tab
vim.opt.shiftwidth = 4 -- # of spaces indenting with `>>`
vim.opt.softtabstop = 4 -- # of spaces a tab counts for
vim.opt.tabstop = 4 -- # of " " for one <Tab>

-- Splits-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Ricing
vim.opt.breakindent = true
vim.opt.cursorline = true -- highlight current line
vim.opt.cursorcolumn = true -- highlight current column
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 1 -- hide additional text like ``` in markdown
vim.opt.list = true -- tab as >, trailingspace as -
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.scrolloff = 10 -- min lines above or below cursor
vim.opt.smartindent = true -- smart indenting on newlines
vim.opt.wrap = false -- disable line wrapping
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.showmode = false -- Don't show the mode, since it's already in status line
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

--vim.opt.completeopt = "menu,menuone,preview"
-- netrw
vim.g.netrw_banner = 0

vim.g.python3_host_prog = vim.env.PYENV_ROOT .. "/versions/nvim/bin/python3"

-- Delete empty space from the end of lines on every save
vim.api.nvim_create_autocmd({ "BufWritePre" }, { command = "%s/\\s\\+$//e" })

--[[
-- TODO: figure out what these actually do
set wildmenu      " enhance command-completion
set wildmode=list:full  " wildcard expansion
set wildoptions=pum
" ins-completion options
set completeopt=menu,menuone,noselect
--]]
