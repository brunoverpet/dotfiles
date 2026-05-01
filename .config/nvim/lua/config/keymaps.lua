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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "gr", function()
      local make_entry = require("telescope.make_entry")
      local devicons = require("nvim-web-devicons")
      local entry_display = require("telescope.pickers.entry_display")
      local utils = require("telescope.utils")

      local default_maker = make_entry.gen_from_quickfix()

      require("telescope.builtin").lsp_references({
        entry_maker = function(line)
          local entry = default_maker(line)
          if not entry then
            return nil
          end

          local icon, icon_hl = devicons.get_icon(entry.filename, nil, { default = true })

          entry.display = function(ent)
            local displayer = entry_display.create({
              separator = " ",
              items = {
                { width = 2 },
                { width = 35 },
                { remaining = true },
              },
            })
            local tail = utils.path_tail(ent.filename)
            return displayer({
              { icon, icon_hl },
              { tail .. ":" .. ent.lnum, "TelescopeResultsIdentifier" },
              ent.text,
            })
          end
          return entry
        end,
      })
    end, { buffer = args.buf, desc = "Goto References (with icons)" })
  end,
})

local function toggle_term()
  Snacks.terminal.toggle()
end

vim.keymap.set("n", "<C-t>", toggle_term, { desc = "Toggle Terminal" })
vim.keymap.set("t", "<C-t>", toggle_term, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<leader>cl", function()
  Snacks.terminal.toggle("claude", {
    win = {
      position = "right",
      border = "left",
      width = 0.30,
      -- height = 0.70,
      wo = { winbar = "" },
    },
  })
end, { desc = "Toggle Claude" })

vim.keymap.set("t", "<leader>cl", function()
  Snacks.terminal.toggle("claude", {
    win = {
      position = "float",
      width = 0.9,
      height = 0.9,
      border = "rounded",
      -- wo = { winbar = "" },
    },
  })
end, { desc = "Toggle Claude" })

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git(), win = { position = "float", width = 0.9, height = 0.9, border = "rounded" } })
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
