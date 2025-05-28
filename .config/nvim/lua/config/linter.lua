---@diagnostic disable: missing-fields
local lint = require("lint")
lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "ruff" },
}

lint.linters.luacheck = {
  cmd = "luacheck",
  stdin = true,
  args = {
    "--globals",
    "vim",
    "--",
  },
  stream = "stdout",
  ignore_exitcode = true,
  parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
    source = "luacheck",
  }),
}
