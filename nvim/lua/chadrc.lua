-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",

  hl_override = {
    Comment = { italic = true },
    Type = { italic = true },
    ["@comment"] = { italic = true },
    ["@type"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }
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
