local M = {}

local ts = vim.treesitter
local ts_query = require("vim.treesitter.query")

M.extract_symbols = function(bufnr)
  local parser = ts.get_parser(bufnr, "lua")
  local tree = parser:parse()[1]:root()
  local query = ts_query.parse("lua", [[
    (function_declaration name: (identifier) @name)
    (class_declaration name: (identifier) @name)
  ]])

  local names = {}
  for _, node, _ in query:iter_matches(tree, bufnr) do
    table.insert(names, ts.get_node_text(node, bufnr))
  end

  return names
end

return M
