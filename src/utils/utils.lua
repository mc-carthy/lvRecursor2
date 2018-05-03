local Utils = {}

function Utils.colour(r, g, b, a)
    return { r, g or r, b or r, a or 255 }
end

return Utils