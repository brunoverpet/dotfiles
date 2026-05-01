-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

-- Démarre le LSP si aucun client n'est attaché au buffer après ouverture d'un fichier TS/JS.
-- Couvre les fichiers créés en dehors de nvim (terminal, explorateur, etc.)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(args)
    vim.defer_fn(function()
      if #vim.lsp.get_clients({ bufnr = args.buf }) == 0 then
        vim.cmd("LspStart")
      end
    end, 500)
  end,
})
