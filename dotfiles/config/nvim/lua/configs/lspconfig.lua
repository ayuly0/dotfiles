require("nvchad.configs.lspconfig").defaults()
local nvlsp = require "nvchad.configs.lspconfig"

local on_attach = nvlsp.on_attach
-- local capabilities = nvlsp.capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities()
local on_init = require("nvchad.configs.lspconfig").on_init
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

lspconfig.qmlls.setup {
  cmd = {
    "qmlls",
    "-E",
    "-I/home/ayuly/Stuffs/quickshell/build/qml_modules",
    "-I/lib/x86_64-linux-gnu/qt6/qml",
    "-I/usr/lib/qml",
  },
  on_new_config = function(new_config, new_root_dir)
    -- Point qmlls to the correct build directory
    new_config.cmd_cwd = new_root_dir
    new_config.env = {
      QMLLS_BUILD_DIR = new_root_dir, -- or change to your actual build path
    }
  end,
  filetypes = { "qml" },
  root_dir = require("lspconfig.util").root_pattern("CMakeLists.txt", "compile_commands.json"),
}

lspconfig.asm_lsp.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "asm", "s", "S" },
  cmd = { "asm-lsp" },
  root_dir = util.root_pattern(".git", ".asm-lsp.toml"),
  settings = {
    assemblerType = "nasm",
  },
}
lspconfig.jdtls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "java" },
  root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git") or vim.fn.getcwd(),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk-amd64",
            default = true,
          },
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      contentProvider = { preferred = "fernflower" },
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.lsp.start {
      name = "jdtls",
      cmd = { "jdtls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "pom.xml", "build.gradle", ".git" }, { upward = true })[1]),
    }
  end,
})
