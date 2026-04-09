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
      },
      terminal = { enabled = false },
    },
    keys = {
      { "<C-t", false },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" } },
    opts = {
      open_mapping = [[<C-t>]],
      direction = "horizontal",
      size = 15,
      shade_terminals = false,
      border = "top", -- le petit trait fin comme sur la capture
      highlights = {
        Normal = { link = "Normal" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "ToggleTermBorder" },
      },
      start_in_insert = true,
      close_on_exit = true,
    },
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
