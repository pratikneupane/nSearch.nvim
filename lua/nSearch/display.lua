local M = {}

M.show_results = function(results)
  vim.fn["fzf#run"]({
    source = results,
    sink = function(item) vim.cmd("edit " .. item) end,
    options = "--prompt='Function > '"
  })
end

return M
