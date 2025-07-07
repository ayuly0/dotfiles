require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"

local on_attach = nvlsp.on_attach
-- local capabilities = nvlsp.capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local configs = require "lspconfig.configs"

if not configs.neocmake then
  configs.neocmake = {
    default_config = {
      cmd = { "neocmakelsp", "--stdio" },
      filetypes = { "cmake" },
      root_dir = function(fname)
        return util.find_git_ancestor(fname)
      end,
      single_file_support = true, -- suggested
      on_attach = on_attach, -- on_attach is the on_attach function you defined
      init_options = {
        format = {
          enable = true,
        },
        lint = {
          enable = true,
        },
        scan_cmake_in_package = true, -- default is true
      },
    },
  }
  lspconfig.neocmake.setup {}
end

lspconfig.slint_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "slint" },
}

-- if not configs.slint_lsp then
--   configs.slint_lsp = {
--     default_config = {
--       cmd = { "slint-lsp" },
--       filetypes = { "slint" },
--       root_dir = function(fname)
--         return util.find_git_ancestor(fname)
--       end,
--       on_attach = on_attach,
--       capabilities = capabilities,
--     },
--   }
-- end
-- lspconfig.slint_lsp.setup {}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

lspconfig.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  tools = {
    autoformatters = { rustfmt = true },
    formatters = { rustfmt = true },
  },
  setting = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
        extraArgs = { "--all-features" },
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  setting = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelperProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}
