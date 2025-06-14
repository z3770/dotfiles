vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader><leader>t", "<cmd>Vterm<cr>", { desc = "Open terminal" })

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_terminal(opts)
  opts = opts or {}
  local ui = vim.api.nvim_list_uis()[1]
  local height = opts.height or math.floor(ui.height * 0.2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    split = "below",
    height = height,
  })
  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_terminal { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Vterm", toggle_terminal, {})
