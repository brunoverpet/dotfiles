return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    })

    opts.extensions = opts.extensions or {}
    table.insert(opts.extensions, {
      filetypes = { "snacks_terminal" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
