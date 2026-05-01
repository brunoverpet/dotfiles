-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Entrée dans une balise HTML ouvre sur une nouvelle ligne bien indentée
vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(col, col)
  local after = line:sub(col + 1, col + 1)

  if
    line:match("><")
    or (before == "{" and after == "}")
    or (before == "(" and after == ")")
    or (before == "[" and after == "]")
  then
    return "<CR><ESC>O"
  end
  return "<CR>"
end, { expr = true, buffer = false })

local function toggle_term()
  Snacks.terminal.toggle()
end

vim.keymap.set("n", "<C-t>", toggle_term, { desc = "Toggle Terminal" })
vim.keymap.set("t", "<C-t>", toggle_term, { desc = "Toggle Terminal" })

vim.keymap.set({ "n", "t" }, "<leader>ct", function()
  Snacks.terminal.toggle("claude", {
    win = {
      position = "float",
      width = 0.9,
      height = 0.9,
      border = "rounded",
      wo = { winbar = "" },
    },
  })
end, { desc = "Toggle Claude" })

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), win = { position = "float", width = 0.9, height = 0.9, border = "rounded" } })
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
