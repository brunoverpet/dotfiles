return {
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.loaded_matchit = 1
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        layout = { preset = "telescope" },
        exclude = { "node_modules", ".git" },
        sources = {
          files = { hidden = true, ignored = true },
          smart = { hidden = true, ignored = true },
          lsp_references = {
            show_line = false,
          },
        },
      },
      explorer = {
        exclude = { ".git" },
        include = { ".env" },
      },
      terminal = {
        enabled = true,
        win = {
          position = "bottom",
          height = 0.3,
          border = "top",
          wo = {
            winbar = "",
            winhighlight = "Normal:Normal,NormalFloat:Normal",
          },
          bo = {
            filetype = "snacks_terminal",
          },
        },
      },
      lazygit = {
        win = {
          style = "lazygit",
        },
      },
    },
    keys = {
      { "<C-t>", false },
    },
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
        -- Ignore node_modules et le dossier git même si on cherche dans les fichiers masqués
        file_ignore_patterns = { "node_modules/", "%.git/" },
      })

      -- Force la recherche à inclure les fichiers cachés (.env) et ignorés dans le picker principal
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      })
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    config = function()
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
