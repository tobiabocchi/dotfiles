-- TODO: keymap to reload config
-- map("n", "<leader>r","<cmd>source $MYVIMRC<CR>")
-- TODO: w!! to save with sudo
-- map("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })
-- map('c', 'w!!', "<cmd>w !sudo tee %<CR>")

vim.g.mapleader = " "

-- Tabs
vim.keymap.set("n", "<c-n>", "<cmd>tabnew<CR>")
-- map("n", "<c-w>", "<cmd>tabclose<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>")
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>")
vim.keymap.set("n", "[T", "<cmd>tabfirst<CR>")
vim.keymap.set("n", "]T", "<cmd>tablast<CR>")

-- Splits
vim.keymap.set("n", "s-", "<cmd>split<CR>")
vim.keymap.set("n", "s|", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Misc mappings
-- Open file explorer (netrw)
vim.keymap.set("n", "<leader>sx", "<cmd>30Lexplore<CR>")
-- Save file
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
-- Quit file, this is used for diagnostics
-- vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- Set vim's directory to current file's dir
vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<CR>")
-- open plugin manager
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")

-- Open the current file in the default program
local open_cmd
if vim.fn.has("mac") then
	open_cmd = "open"
elseif vim.fn.has("linux") then
	open_cmd = "xdg-open"
end
vim.keymap.set("n", "<leader>x", "<cmd>!" .. open_cmd .. " %<CR><CR>")

-- Visual mode stuff
-- Move text in visual mode: https://stackoverflow.com/questions/41084565/moving-multiple-lines-in-vim-visual-mode
-- TODO: convert to <cmd> syntax
vim.keymap.set("x", "K", ":m-2<CR>gv=gv", {})
vim.keymap.set("x", "J", ":m'>+<CR>gv=gv", {})

-- Reselect visual selection after indenting
vim.keymap.set({ "v", "s" }, "<", "<gv")
vim.keymap.set({ "v", "s" }, ">", ">gv")

-- Yanking/Copying/Pasting
-- Maintain the cursor position when yanking a visual selection
--" http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")
-- Multiple pasting in visual mode, without overwriting the default register
vim.keymap.set("x", "<leader>p", '"_dP')
-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>Y", '"+Y')
