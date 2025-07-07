return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    event = "BufWritePre",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "edluffy/hologram.nvim",
    -- event = "VeryLazy",
    config = function()
      local hologram = require "hologram"
      hologram.setup {
        auto_display = true,
      }
    end,
  },
  { "nvim-neotest/nvim-nio", lazy = false },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "/home/ayuly/.local/share/nvim/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    ft = "python",
    evnet = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  { "mattn/emmet-vim", lazy = false },
  { "neocmakelsp/neocmakelsp" },
  { "posva/vim-vue" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    ft = { "python", "go" },
    opts = function()
      return require "configs.null-ls"
    end,
  },
  -- {
  --   "olexsmir/gopher.nvim",
  --   ft = "go",
  --   config = function (_, opts)
  --     require("gopher").setup(opts)
  --   end,
  --   build = function ()
  --     vim.cmd [[slient! GoInstallDeps]]
  --   end
  -- },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "rust-analyzer",
      "clangd",
      "clang-format",
      "codelldb",
      "pyright",
      "black",
      "debugpy",
      "mypy",
      "ruff",
      "gopls",
      "neocmakelsp",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "rust",
        "toml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
    "tanvirtin/vgit.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = "VimEnter",
    config = function()
      require("vgit").setup()
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",
    opts = {
      keymap = { preset = "super-tab" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        -- list = { selection = { preselect = true, auto_insert = true } },
        menu = { draw = { treesitter = { "lsp" } } },
      },

      signature = { enabled = true },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup {
        extra_groups = {
          "NormalFloat",
          "NvimTreeNormal",
        },
        exclude_groups = {},
        -- disable nvchad autocomplete
        require("cmp").setup.buffer { enabled = false },
      }
    end,
  },
}
