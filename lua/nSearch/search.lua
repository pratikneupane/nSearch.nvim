local M = {}

M.embed_query = function(query)
  local cmd =
  "python3 -c 'import sys; from sentence_transformers import SentenceTransformer; model = SentenceTransformer(\"all-MiniLM-L6-v2\"); print(model.encode(sys.argv[1]).tolist())' \"" ..
  query .. "\""
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return vim.json.decode(result)
end

M.search = function(query)
  local extracted = require("nSearch.parser").extract_symbols(0)
  local best_match = nil
  local best_score = -1

  for _, func in ipairs(extracted) do
    local score = require("nSearch.utils").cosine_similarity(M.embed_query(query), M.embed_query(func))
    if score > best_score then
      best_score = score
      best_match = func
    end
  end

  print("Best match: " .. (best_match or "None found"))
end

return M
