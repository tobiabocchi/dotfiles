local o = vim.o
local g = vim.g

-- Search
o.hlsearch   = false -- don't highlight search pattern
o.ignorecase = true -- case insensitive search
o.smartcase  = true -- case sensitive if upper case in search pattern

-- General options
vim.g.mapleader = " "
o.autowrite = true
o.errorbells     = false -- no bell on error
o.mouse          = 'n'   -- allow mouse in normal mode
o.swapfile       = false -- don't use swap file

-- undo management
local undodir_path = vim.env.HOME .. '/.local/share/nvim/undodir'
if vim.fn.isdirectory(undodir_path) == 0 then -- dir doesn't exist, create it
    vim.fn.mkdir(undodir_path, "p")
end
o.undofile = true
o.undodir  = undodir_path

-- Tab handling
o.expandtab   = true -- insert spaces instead of tab
o.shiftwidth  = 4 -- # of spaces indenting with `>>`
o.softtabstop = 4 -- # of spaces a tab counts for
o.tabstop     = 4 -- # of " " for one <Tab>

-- Ricing
o.cursorline     = true -- highlight current line
o.guicursor      = ""
o.list           = true -- tab as >, trailingspace as -
o.number         = true -- show line numbers
o.relativenumber = true -- show relative line numbers
o.scrolloff      = 20 -- min lines above or below cursor
o.showmode       = true -- show current mode under cmdline
o.smartindent    = true -- smart indenting on newlines
o.wrap           = false -- disable line wrapping

-- netrw
g.netrw_banner = 0

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
