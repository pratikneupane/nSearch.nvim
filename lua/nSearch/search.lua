local M = {}

M.embed_query = function(query)
    local cmd = "python3 -c 'import sys; from sentence_transformers import SentenceTransformer; model = SentenceTransformer(\"all-MiniLM-L6-v2\"); print(model.encode(sys.argv[1]).tolist())' \"" .. query .. "\""
    local handle = io.popen(cmd)
    if not handle then
        vim.notify("Failed to execute embedding command", vim.log.levels.ERROR)
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    local ok, decoded = pcall(vim.json.decode, result)
    if not ok then
        vim.notify("Failed to decode embedding: " .. tostring(decoded), vim.log.levels.ERROR)
        return nil
    end
    return decoded
end

M.search = function(query)
    local extracted = require("nsearch.parser").extract_symbols(0)
    local best_match = nil
    local best_score = -1

    for _, func in ipairs(extracted) do
        local query_embed = M.embed_query(query)
        local func_embed = M.embed_query(func)
        if query_embed and func_embed then
            local score = require("nsearch.utils").cosine_similarity(query_embed, func_embed)
            if score > best_score then
                best_score = score
                best_match = func
            end
        end
    end

    if best_match then
        print("Best match: " .. best_match .. " (Score: " .. best_score .. ")")
        require("nsearch.display").show_results({best_match})
    else
        vim.notify("No matching symbols found", vim.log.levels.WARN)
    end
end

return M
