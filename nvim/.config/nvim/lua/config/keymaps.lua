vim.keymap.set("n", "<leader><leader>X", "<cmd>source %<cr>", { desc = "Source %" })
vim.keymap.set("n", "<leader><leader>x", ":.lua<cr>", { desc = "Source row" })
vim.keymap.set("v", "<leader><leader>x", ":lua<cr>", { desc = "Source selected" })

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
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
