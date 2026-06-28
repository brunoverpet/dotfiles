return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "bottom",
        height = 0.3,
        wo = { winbar = "", winhighlight = "WinSeparator:WinSeparator" },
      },
    },
  },
  keys = {
    {
      "<C-t>",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle Terminal",
      mode = { "n", "t" },
    },
  },
}
