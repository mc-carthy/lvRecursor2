local Utils = {}

function Utils.colour(r, g, b, a)
    return { r, g or r, b or r, a or 255 }
end

function Utils.pointInRect(point, rect)
    assert(point.x ~= nil and point.y ~= nil, 'Point requires an x and y attribute')
    assert(rect.x ~= nil and rect.w ~= nil and rect.y ~= nil and rect.h ~= nil, 'Rect requires x, y, w & h attributes')
    return not (
        point.x < rect.x or
        point.x > rect.x + rect.w or
        point.y < rect.y or
        point.y > rect.y + rect.h
    )
end

function Utils.mouseInBounds(self, mouseX, mouseY)
    return 
        mouseX >= self.pos.x - self.size.x / 2 and
        mouseX <= self.pos.x + self.size.x / 2 and
        mouseY >= self.pos.y - self.size.y / 2 and
        mouseY <= self.pos.y + self.size.y / 2
end

return Utils