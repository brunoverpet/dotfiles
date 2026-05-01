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
    vim.schedule(function()
    vim.keymap.set("n", "gr", function()
      local make_entry = require("telescope.make_entry")
      local devicons = require("nvim-web-devicons")
      local entry_display = require("telescope.pickers.entry_display")
      local default_maker = make_entry.gen_from_quickfix()

      require("telescope.builtin").lsp_references({
        entry_maker = function(line)
          local entry = default_maker(line)
          if not entry or entry.filename:find("node_modules", 1, true) then
            return nil
          end
          local icon, icon_hl = devicons.get_icon(entry.filename, nil, { default = true })
          entry.display = function(ent)
            local displayer = entry_display.create({
              separator = " ",
              items = { { width = 2 }, { width = 45 }, { remaining = true } },
            })
            local abs = vim.fn.fnamemodify(ent.filename, ":p")
            local root = LazyVim.root() .. "/"
            local relative = abs:sub(1, #root) == root and abs:sub(#root + 1) or vim.fn.fnamemodify(abs, ":t")
            return displayer({
              { icon, icon_hl },
              { relative .. ":" .. ent.lnum, "TelescopeResultsIdentifier" },
              ent.text,
            })
          end
          return entry
        end,
      })
    end, { buffer = args.buf, desc = "Goto References (with icons)" })
    end) -- vim.schedule
  end,
})

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
