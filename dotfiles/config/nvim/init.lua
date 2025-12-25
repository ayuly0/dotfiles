vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.filetype.add {
  extension = {
    slint = "slint",
  },
}

vim.lsp.inlay_hint.enable(true)

-- set custom highlight colors for gitsigns
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6da95", bg = "NONE" }) -- Green

if vim.g.neovide then
  vim.cmd "TransparentDisable"
else
  vim.cmd "TransparentEnable"
end

vim.o.shell = vim.fn.exepath("fish")
