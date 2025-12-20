-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "monochrome",

  hl_override = {
    Comment = { fg = "#837f8f", italic = true },
    Type = { italic = true },
    LspInlayHint = { fg = "#837f8f", bg = "NONE" },
    ["@comment"] = { fg = "#837f8f", italic = true },
    ["@lspinlayhint"] = { fg = "#837f8f", bg = "NONE" },
    ["@type"] = { italic = true },
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "round",
  },
  --  tabufline = {
  --     lazyload = false
  -- }
}

return M
