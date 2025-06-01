local map = vim.keymap.set

-- map(
--   { "i", "n" },
--   "<C-s>",
--   vim.lsp.buf.signature_help,
--   { desc = "LSP Signature Help" }
-- )

-- map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
-- map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
-- map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

map(
  { "n", "v" },
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = "Code Action" }
)

-- UTILS

map(
  "n",
  "<Tab>",
  ":bnext<CR>",
  { noremap = true, silent = true, desc = "Next buff" }
)
map(
  "n",
  "<S-Tab>",
  ":bprevious<CR>",
  { noremap = true, silent = true, desc = "Prev buff" }
)

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR><Esc>",
  { desc = "Remove search highlight" }
)

map("n", "n", "nzzzv", { noremap = true, silent = true })
map("n", "N", "Nzzzv", { noremap = true, silent = true })
