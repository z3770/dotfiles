local map = vim.keymap.set

map("n", "[d", function()
  vim.diagnostic.goto_prev({})
end, { desc = "Prev error" })
map("n", "]d", function()
  vim.diagnostic.goto_next({})
end, { desc = "Next error" })

map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

map(
  { "i", "n" },
  "<C-s>",
  vim.lsp.buf.signature_help,
  { desc = "LSP Signature Help" }
)

map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

map(
  { "n", "v" },
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = "Code Action" }
)

map(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle<CR>",
  { desc = "Trouble: toggle diagnostics" }
)

map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "Open lazy git" })

-- UTILS
map(
  "n",
  "<leader>q",
  ":bd<CR>",
  { noremap = true, silent = true, desc = "Close buffer" }
)

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

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvim-tree" })

-- Cursor movement in Insert
map("i", "<C-h>", "<Left>", { noremap = true, silent = true })
map("i", "<C-l>", "<Right>", { noremap = true, silent = true })
map("i", "<C-j>", "<Down>", { noremap = true, silent = true })
map("i", "<C-k>", "<Up>", { noremap = true, silent = true })

map("n", "<leader>nm", "<cmd>NoiceHistory<CR>", { desc = "Noice History" })

-- Telescope
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
  map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
  map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Grep" })
  map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
  map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help" })
end

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

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
local smart_splits = require("smart-splits")
map("n", "<C-S-h>", smart_splits.resize_left)
map("n", "<C-S-j>", smart_splits.resize_down)
map("n", "<C-S-k>", smart_splits.resize_up)
map("n", "<C-S-l>", smart_splits.resize_right)
-- moving between splits
map("n", "<C-h>", smart_splits.move_cursor_left)
map("n", "<C-j>", smart_splits.move_cursor_down)
map("n", "<C-k>", smart_splits.move_cursor_up)
map("n", "<C-l>", smart_splits.move_cursor_right)
-- swapping buffers between windows
map("n", "<leader><leader>h", smart_splits.swap_buf_left)
map("n", "<leader><leader>j", smart_splits.swap_buf_down)
map("n", "<leader><leader>k", smart_splits.swap_buf_up)
map("n", "<leader><leader>l", smart_splits.swap_buf_right)

map("n", "<leader>vc", function()
  require("treesitter-context").toggle()
end, { desc = "Toggle Treesitter Context" })

map("n", "<leader>vt", function()
  require("transparent").toggle()
end, { desc = "Toggle Transparency" })

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Harpoon: Append" })

map("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: List " })

map("n", "<C-S-N>", function()
  harpoon:list():next()
end, { desc = "Harpoon: Next" })

map("n", "<C-S-P>", function()
  harpoon:list():prev()
end, { desc = "Harpoon: Prev" })

for i = 1, 5 do
  map("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon to file" .. i })
end
