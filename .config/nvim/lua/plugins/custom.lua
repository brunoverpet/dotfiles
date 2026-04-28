return {
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "gruvbox",
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      -- Désactive le plugin natif matchit pour éviter les conflits
      vim.g.loaded_matchit = 1
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
        ts_ls = {
          settings = {
            typescript = {
              preferences = {
                includeCompletionsForModuleExports = false,
                includeCompletionsForImportStatements = false,
                includeCompletionsWithSnippetText = false,
                includeAutomaticOptionalChainCompletions = true,
              },
            },
            javascript = {
              preferences = {
                includeCompletionsForModuleExports = false,
                includeCompletionsForImportStatements = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- affiche les dotfiles
        ignored = true,
      },
      explorer = {
        exclude = { ".git" },
        include = { ".env" },

        actions = {
          terminal = false,
        },
      },
      terminal = { enabled = false },
    },
    keys = {
      { "<C-t>", false },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    keys = { { "<C-:>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" } },
    opts = {
      open_mapping = [[<C-:>]],
      direction = "horizontal",
      size = 15,
      shade_terminals = false,
      border = "top",
      highlights = {
        Normal = { link = "Normal" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "ToggleTermBorder" },
      },
      start_in_insert = true,
      close_on_exit = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal
      local claude = Terminal:new({
        cmd = "claude",
        direction = "float",
        float_opts = {
          border = "rounded",
          width = math.floor(vim.o.columns * 0.70), -- moins large
          height = math.floor(vim.o.lines * 0.70), -- moins haut
          winblend = 5,
        },
        hidden = true,
        on_open = function(term)
          -- toggle depuis le terminal avec F4
          vim.keymap.set("t", "<leader>cl", function()
            term:toggle()
          end, { buffer = term.bufnr })
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        claude:toggle()
      end, { desc = "Toggle Claude" })
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
          win_options = {
            winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
          },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        icons_enabled = true,
        theme = "gruvbox",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- disabled_filetypes = { "lazygit" },
        always_divide_middle = true,
        globalstatus = false,
      })

      opts.sections = {
        -- lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        -- lualine_z = { "fileformat", "filetype" },
      }
      return opts
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.9,
          height = 0.85,
          preview_width = 0.6,
        },
      })
    end,
  },
  {
    "nvim-mini/mini.nvim",
    version = "*",
    config = function()
      -- seulement le module surround
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
        },
      })
    end,
  },
}
