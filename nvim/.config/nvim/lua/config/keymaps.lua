vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Declaration" })
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Remove search highlight" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
