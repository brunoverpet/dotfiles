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
      })
    end,
  },
  {
    "nvim-mini/mini.nvim",
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
