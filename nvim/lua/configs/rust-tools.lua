local configs = require "nvchad.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities


local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  tools = {
        autoSetHints = true,
        runnables = {
            use_telescope = true,
        },
        hover_actions = {
            border = {
                {"+", "Purple"},
                {"-", "Purple"},
                {"-", "Purple"},
                {"|", "Purple"},
                {"|", "Purple"},
                {"-", "Purple"},
                {"-", "Purple"},
                {"+", "Purple"},
            },
        },
        inlay_hints = {
            auto = true,
            only_current_line = false,
        },
        on_initialized = function()
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.rs" },
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end,
    },
}
return options
