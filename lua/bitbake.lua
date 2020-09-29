local M = {}

function M.getCompletionItems(prefix, score_func)
    local task = vim.api.nvim_call_function('bitbake#gather_candidates', {'task'})
    local variables = vim.api.nvim_call_function('bitbake#gather_candidates', {'variable'})
    local varflags = vim.api.nvim_call_function('bitbake#gather_candidates', {'varflag'})

    local complete_items = {}

    complete_items = table_concat(task, complete_items)
    complete_items = table_concat(variables, complete_items)
    complete_items = table_concat(varflags, complete_items)

    return complete_items
end

function table_concat(src, dest)
    for k,v in pairs(src) do
        table.insert(dest, v)
    end

    return dest
end

M.complete_item = {
    item = M.getCompletionItems
}

return M
