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
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.none-ls" -- move your opts here
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
      "asm-lsp",
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
      "ada-language-server",
      "asmfmt",
      "lua-language-server",
      "prettier",
      "qmlls",
      "slint-lsp",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vetur-vls",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "asm",
        "c",
        "cpp",
        "go",
        "qmljs",
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
        require("cmp").setup {
          sources = {},
        },
        on_clear = function() end,
      }
      -- require('transparent').clear_prefix('BufferLine')
      require("transparent").clear_prefix "NeoTree"
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>ee",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (current file's dir)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.loop.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function()
      require("mini.files").setup {
        -- Optional nice defaults
        mappings = {
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          synchronize = "=", -- I prefer = instead of default S
          close = "q",
        },
        windows = {
          preview = true,
          width_preview = 50,
        },
        options = {
          use_as_default_explorer = true, -- This replaces netrw and makes :edit . use mini.files
        },
      }

      -- Optional: auto-close when last window
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "<Esc>", function()
            require("mini.files").close()
          end, { buffer = buf_id })
        end,
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ft = { "markdown" },
    opts = {},
    config = function()
      require("render-markdown").setup {
        completions = { blink = { enabled = true } },
        heading = {
          position = "inline",
          enabled = true,
          render_modes = false,
          atx = true,
          setext = true,
          sign = true,
          above = "▄",
          below = "▀",
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
        },
        indent = {
          enabled = false,
          render_modes = false,
          per_level = 2,
          skip_level = 1,
          skip_heading = false,
          icon = "▎",
          highlight = "RenderMarkdownIndent",
        },
        pipe_table = { preset = "round" },
        bullet = { icons = { "", "" } },
      }
      require("render-markdown").enable()
    end,
  },
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    lazy = false,
    config = function()
      require("competitest").setup {
        floating_border = "rounded",
        floating_border_highlight = "FloatBorder",
        compile_command = {
          cpp = { exec = "g++", args = { "$(FNAME)", "-o", "build/$(FNOEXT)" } },
        },
        run_command = {
          cpp = { exec = "./build/$(FNOEXT)" },
        },
        maximum_time = 1000,
        testcases_directory = "testcases/",
        testcases_input_file_format = "$(FNOEXT)_$(TCNUM).INP",
        testcases_output_file_format = "$(FNOEXT)_$(TCNUM).OUT",
        runner_ui = {
          interface = "split",
        },
      }
    end,
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    lazy = false,
    config = function()
      require("mini.cursorword").setup {}
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    lazy = false,
    config = function()
      require("mini.move").setup {}
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    lazy = false,
    config = function()
      require("mini.ai").setup {}
    end,
  },
  {
    "kawre/leetcode.nvim",
    lazy = false,
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      editor = {
        reset_previous_code = true, ---@type boolean
        fold_imports = true, ---@type boolean
      },
      injector = {
        ["cpp"] = {
          imports = function()
            return {
              '#pragma GCC optimize("O3,unroll-loops,inline")',
              '#pragma GCC target("avx2,bmi,bmi2,lzcnt")',
              "#include <bits/stdc++.h>",
              "using namespace std;",
              "using ll = long long;",
              "using vi = vector<int>;",
              "using vll = vector<ll>;",
              "#define forn(s,i,e) for(int i=s;i<e;++i)",
              "#define all(x) (x).begin(), (x).end()",
              "#define sz(x) int((x).size())",
              "#define pb push_back",
              "#define fi first",
              "#define se second",
              "#define vec vector",
              "static const int _fast_io = [](){",
              " ios::sync_with_stdio(false);",
              " cin.tie(nullptr);",
              " return 0;",
              "}();",
              "",
              'void dbg() { cout << "\\n"; }',
              "template <typename H, typename... T>",
              "void dbg(H h, T... t) {",
              ' cout << h << " ";',
              " dbg(t...);",
              "}",
              "int search( vector<int> &nums, int target )",
              "{",
              "int l = 0, r = nums.size() - 1;",
              "while ( l <= r )",
              "{",
              "int mid = ( l + r ) / 2;",
              "if ( nums[ mid ] > target )",
              "{",
              "r = mid - 1;",
              "}",
              "else if ( nums[ mid ] < target )",
              "{",
              "l = mid + 1;",
              "}",
              "else",
              "{",
              "return mid;",
              "}",
              "}",
              "return -1;",
              "}",
            }
          end,
          after = 'auto init = atexit([]() { ofstream("display_runtime.txt") << "0";});',
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup {
        -- optional: customize timeouts, stages, icons, etc.
        timeout = 5000,
        stages = "fade",
        background_colour = "#222222",
      }
      vim.notify = require "notify"
    end,
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("java").setup()
    end,
  },
}
