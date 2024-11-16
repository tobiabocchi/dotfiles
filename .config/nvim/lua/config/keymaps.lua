-- TODO: keymap to reload config
-- map("n", "<leader>r","<cmd>source $MYVIMRC<CR>")
-- TODO: w!! to save with sudo
-- map("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })
-- map('c', 'w!!', "<cmd>w !sudo tee %<CR>")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tabs
vim.keymap.set("n", "<c-n>", "<cmd>tabnew<CR>", { desc = "Create new tab" })
-- map("n", "<c-w>", "<cmd>tabclose<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Move focus to previous tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Move focus to next tab" })
vim.keymap.set("n", "[T", "<cmd>tabfirst<CR>", { desc = "Move focus to first tab" })
vim.keymap.set("n", "]T", "<cmd>tablast<CR>", { desc = "Move focus to last tab" })

-- Splits
vim.keymap.set("n", "s-", "<cmd>split<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "s|", "<cmd>vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Misc mappings
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write to file" })
vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<CR>", { desc = "Set vim's directory to current file's directory" })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy plugin manager" })

-- Open the current file in the default program
local open_cmd
if vim.fn.has("mac") then
	open_cmd = "open"
elseif vim.fn.has("linux") then
	open_cmd = "xdg-open"
end
vim.keymap.set(
	"n",
	"<leader>x",
	"<cmd>!" .. open_cmd .. " %<CR><CR>",
	{ desc = "Open the current file in the default program" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Visual mode stuff
-- Move text in visual mode: https://stackoverflow.com/questions/41084565/moving-multiple-lines-in-vim-visual-mode
-- TODO: convert to <cmd> syntax
vim.keymap.set("x", "K", ":m-2<CR>gv=gv", {})
vim.keymap.set("x", "J", ":m'>+<CR>gv=gv", {})

-- Reselect visual selection after indenting
vim.keymap.set({ "v", "s" }, "<", "<gv")
vim.keymap.set({ "v", "s" }, ">", ">gv")

-- Yanking/Copying/Pasting
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- Maintain the cursor position when yanking a visual selection
--" http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")
-- Multiple pasting in visual mode, without overwriting the default register
vim.keymap.set("x", "<leader>p", '"_dP')
-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>Y", '"+Y')
