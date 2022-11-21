local map = vim.keymap.set

-- TODO: keymap to reload config
-- map("n", "<leader>r","<cmd>source $MYVIMRC<CR>")

map("n", "<leader>fx", "<cmd>30Lexplore<CR>")
map("n", "<leader>w", "<cmd>w<CR>")

-- Tabs
map("n", "<c-n>", "<cmd>tabnew<CR>")
-- map("n", "<c-w>", "<cmd>tabclose<CR>")
map("n", "[t", "<cmd>tabprevious<CR>")
map("n", "]t", "<cmd>tabnext<CR>")
map("n", "[T", "<cmd>tabfirst<CR>")
map("n", "]T", "<cmd>tablast<CR>")

-- Split windows
map("n", "s-", "<cmd>split<CR>")
map("n", "s|", "<cmd>vsplit<CR>")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- Move text in visual mode
map('x', 'J', ":move '<+1<CR>gv=gv", {})
map('x', 'K', ":move '<-2<CR>gv=gv", {})

-- Open the current file in the default program
local open_cmd
if vim.fn.has("mac") then open_cmd = "open"
elseif vim.fn.has("linux") then open_cmd = "xdg-open" end
map("n", "<leader>x", "<cmd>!"..open_cmd.." %<cr><cr>")

-- Maintain the cursor position when yanking a visual selection
--" http://ddrscott.github.io/blog/2016/yank-without-jank/
map("v", "y", "myy`y")
map("v", "Y", "myY`y")
-- Multiple pasting in visual mode
map("x", "<leader>p", '"_dP')
map("n", "<leader>cd", "<cmd>lcd %:p:h<cr>")
-- TODO: fix this
map({"n", "v"}, "<leader>y", "\"+y")
map({"n"}, "<leader>Y", "\"+Y")

-- Reselect visual selection after indenting
map({"v", "s"}, "<", "<gv")
map({"v", "s"}, ">", ">gv")
-- w!! to save with sudo
-- map("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })
-- map('c', 'w!!', "<cmd>w !sudo tee %<CR>")

--[=====[

" luasnip
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' " Tab to expand or jump
inoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>                                " -1 to jump backward
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'         " Changing choices in choiceNodes
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" Copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
--]=====]
