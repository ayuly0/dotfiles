local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    css = { "prettier" },
    html = { "prettier" },
    vue = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    nasm = { "nasm_indent" },
    gas = { "asmfmt" },
    asm = { "asmfmt" },
    java = { "google_java_format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
