-- Search
vim.opt.hlsearch   = false -- don't highlight search pattern
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase  = true -- case sensitive if upper case in search pattern

-- General options
vim.opt.autowrite = true
vim.opt.errorbells     = false -- no bell on error
vim.opt.mouse          = 'n'   -- allow mouse in normal mode
vim.opt.swapfile       = false -- don't use swap file

-- undo management
local undodir_path = vim.env.HOME .. '/.local/share/nvim/undodir'
if vim.fn.isdirectory(undodir_path) == 0 then -- dir doesn't exist, create it
    vim.fn.mkdir(undodir_path, "p")
    -- TODO: look into dir permission, 700?
end
vim.opt.undofile = true
vim.opt.undodir  = undodir_path

-- Tab handling
vim.opt.expandtab   = true -- insert spaces instead of tab
vim.opt.shiftwidth  = 4 -- # of spaces indenting with `>>`
vim.opt.softtabstop = 4 -- # of spaces a tab counts for
vim.opt.tabstop     = 4 -- # of " " for one <Tab>

-- Ricing
vim.opt.cursorline     = true -- highlight current line
-- vim.opt.guicursor      = ""
vim.opt.list           = true -- tab as >, trailingspace as -
vim.opt.number         = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.scrolloff      = 8 -- min lines above or below cursor
vim.opt.smartindent    = true -- smart indenting on newlines
vim.opt.wrap           = false -- disable line wrapping
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
-- vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- netrw
vim.g.netrw_banner = 0

-- Delete empty space from the end of lines on every save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    command = "%s/\\s\\+$//e",
})

--[[
-- TODO: figure out what these actually do
set wildmenu      " enhance command-completion
set wildmode=list:full  " wildcard expansion
set wildoptions=pum
" ins-completion options
set completeopt=menu,menuone,noselect
--]]
