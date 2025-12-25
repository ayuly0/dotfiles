require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Open compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap(
  "n",
  "<S-F6>",
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
    .. "<cmd>CompilerRedo<cr>",
  { noremap = true, silent = true }
)

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "<S-F7>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
require("compiler").setup {
  open_qflist = true,
}

-- Inlay Hints
vim.api.nvim_set_keymap(
  "n",
  "<leader>ih",
  "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
  { desc = "Toggle Inlay Hints", noremap = true, silent = true }
)

-- Quickfix
vim.keymap.set("n", "<leader>qf", function()
  local qf_open = not vim.tbl_isempty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix"))
  if qf_open then
    vim.cmd.cclose()
  else
    vim.cmd "botright copen"
  end
end, { desc = "Toggle Quickfix", silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Function to change font size
local function change_font_size(delta)
  local current = vim.o.guifont
  local name, size = string.match(current, "^(.-):h(%d+)$")
  if name and size then
    local new_size = math.max(6, tonumber(size) + delta) -- Minimum size = 6
    vim.o.guifont = string.format("%s:h%d", name, new_size)
  end
end

local function set_font_size(font_size)
  local current = vim.o.guifont
  local name, size = string.match(current, "^(.-):h(%d+)$")
  vim.o.guifont = string.format("%s:h%d", name, font_size)
end

vim.keymap.set("n", "<C-=>", function()
  change_font_size(1)
end, { desc = "Zoom in" })
vim.keymap.set("n", "<C-->", function()
  change_font_size(-0.5)
end, { desc = "Zoom out" })
vim.keymap.set("n", "<C-0>", function()
  set_font_size(12)
end, { desc = "Reset zoom" })

vim.keymap.set("n", "<leader>tt", function()
  vim.o.showtabline = (vim.o.showtabline == 0) and 2 or 0
  print("Tabline is now", vim.o.showtabline == 0 and "OFF" or "ON")
end, { desc = "Toggle Neovim tabline" })

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-S-j>", function()
  vim.cmd "cnext"
  vim.cmd "copen"
end, opts)

vim.keymap.set("n", "<C-S-k>", function()
  vim.cmd "cprev"
  vim.cmd "copen"
end, opts)

-- Competitest
vim.api.nvim_set_keymap("n", "<leader>cpr", "<cmd>CompetiTest run<cr>", { desc = "Run testcases compile" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>cpn",
  "<cmd>CompetiTest run_no_compile<cr>",
  { desc = "Run testcases no compile" }
)
vim.api.nvim_set_keymap("n", "<leader>cpa", "<cmd>CompetiTest add_testcase<cr>", { desc = "Add testcase" })
vim.api.nvim_set_keymap("n", "<leader>cpt", "<cmd>CompetiTest receive<cr>", { desc = "Receive" })
vim.api.nvim_set_keymap("n", "<leader>cpe", "<cmd>CompetiTest edit_testcase<cr>", { desc = "Edit testcase" })

-- Leet.nvim
vim.api.nvim_set_keymap("n", "<leader>lcr", "<cmd>Leet run<cr>", { desc = "Leet run" })
vim.api.nvim_set_keymap("n", "<leader>lcs", "<cmd>Leet submit<cr>", { desc = "Leet submit" })
vim.api.nvim_set_keymap("n", "<leader>lcc", "<cmd>Leet console<cr>", { desc = "Leet console" })
vim.api.nvim_set_keymap("n", "<leader>lcif", "<cmd>Leet info<cr>", { desc = "Leet info" })
vim.api.nvim_set_keymap("n", "<leader>lcij", "<cmd>Leet inject<cr>", { desc = "Leet inject" })
vim.api.nvim_set_keymap("n", "<leader>lcl", "<cmd>Leet list<cr>", { desc = "Leet list" })
vim.api.nvim_set_keymap("n", "<leader>lce", "<cmd>Leet exit<cr>", { desc = "Leet exit" })
vim.api.nvim_set_keymap("n", "<leader>lch", "<cmd>Leet hints<cr>", { desc = "Leet hints" })
vim.api.nvim_set_keymap("n", "<leader>lcd", "<cmd>Leet desc<cr>", { desc = "Leet desc" })
vim.api.nvim_set_keymap("n", "<leader>lcm", "<cmd>Leet menu<cr>", { desc = "Leet menu" })
vim.api.nvim_set_keymap("n", "<leader>lct", "<cmd>Leet tabs<cr>", { desc = "Leet menu" })
