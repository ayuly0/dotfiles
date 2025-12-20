require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- vim.o.guifont = "FiraCode Nerd Font:h11"
vim.o.guifont = "Zed Plex Mono:h12"
-- vim.g.neovide_transparency = 0.85
vim.g.neovide_opacity = 0.85
vim.g.transparency = 0.0
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.cmd [[
  autocmd FileType go,c,cpp,java,python setlocal autoindent noexpandtab tabstop=4 shiftwidth=4
]]

vim.g.neovide_window_blurred = true
vim.g.neovide_cursor_animate_command_line = true

vim.opt.number = true
vim.opt.relativenumber = true

-- show invisible chars
vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  tab = "→ ",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
  eol = "↴",
}
