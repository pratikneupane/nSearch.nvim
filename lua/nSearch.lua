local M = {}

M.setup = function()
  vim.api.nvim_set_keymap("n", "<leader>fs", ":lua require('nSearch').search()<CR>", { noremap = true })
end

return M

