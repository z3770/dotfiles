-- markdownlint reads its rules from .markdownlint-cli2.yaml in this config dir
-- (a project's own config still applies on top).
local config = vim.fn.stdpath("config") .. "/.markdownlint-cli2.yaml"

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = { args = { "--config", config, "-" } },
      },
    },
  },
}
