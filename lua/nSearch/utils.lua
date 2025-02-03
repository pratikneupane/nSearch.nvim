local M = {}

M.cosine_similarity = function(vec1, vec2)
  if #vec1 ~= #vec2 then
    return 0
  end
  local dot_product = 0
  local norm1 = 0
  local norm2 = 0
  for i = 1, #vec1 do
    dot_product = dot_product + (vec1[i] * vec2[i])
    norm1 = norm1 + (vec1[i] * vec1[i])
    norm2 = norm2 + (vec2[i] * vec2[i])
  end
  norm1 = math.sqrt(norm1)
  norm2 = math.sqrt(norm2)
  if norm1 == 0 or norm2 == 0 then
    return 0
  end
  return dot_product / (norm1 * norm2)
end

return M
