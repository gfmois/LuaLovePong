local Utils = {}

function Utils.switch(value, cases)
    local case = cases[value]
    if case then
        return case()
    end

    local def = cases["default"]
    return def and def() or nil
end

return Utils