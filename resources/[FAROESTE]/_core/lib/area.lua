local defaults = {
    height = 2.0,
    color = {255,255,255,60},
    fade = 100,
    threshold = 3.25,
    wallFade = 0,
}

local DEBUGVALUE = nil

local function sanityCheck(area)
    --TODO actually sanity check
    return true
end

local function _dotProduct(A,B,C)
    local BAx = A.x - B.x
    local BAy = A.y - B.y
    local BCx = C.x - B.x
    local BCy = C.y - B.y
    return (BAx * BCx + BAy * BCy)
end
local function _crossProduct(A,B,C)
    local BAx = A.x - B.x
    local BAy = A.y - B.y
    local BCx = C.x - B.x
    local BCy = C.y - B.y
    return (BAx * BCy - BAy * BCx)
end
local function _lineDistanceSquared(A,B,C)
    local Dx = B.x - A.x
    local Dy = B.y - A.y
    local t = ((C.x - A.x) * Dx + (C.y - A.y) * Dy) / (Dx * Dx + Dy * Dy)

    if t < 0 then
        Dx = C.x - A.x
        Dy = C.y - A.y
    elseif t > 1 then
        Dx = C.x - B.x
        Dy = C.y - B.y
    else
        local closestX = A.x + t * Dx
        local closestY = A.y + t * Dy
        Dx = C.x - closestX
        Dy = C.y - closestY
    end
    return Dx*Dx + Dy*Dy
end

local function _wall(p1,p1a,p2,p2a,R,G,B,A,compare)
    if A > 0 then
        if not compare then
            Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p1,p1a,p2,R,G,B,A)
            Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p1a,p2a,p2,R,G,B,A)
            Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p2,p2a,p1a,R,G,B,A)
            Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p2,p1a,p1,R,G,B,A)
        else
            local outerProduct = (compare.x-p1.x)*(p2.y-p1.y) - (compare.y-p1.y)*(p2.x-p1.x)
            if outerProduct <= 0 then
                Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p1,p1a,p2,R,G,B,A)
                Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p1a,p2a,p2,R,G,B,A)
            else
                Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p2,p2a,p1a,R,G,B,A)
                Citizen.InvokeNative(`DRAW_POLY` & 0xFFFFFFFF, p2,p1a,p1,R,G,B,A)
            end
        end
    end
end

local function _drawLabel(where,what,r,g,b,a)
    local onScreen,x,y = GetScreenCoordFromWorldCoord(where.x,where.y,where.z)
    if onScreen then
        SetTextColour(r,g,b,a)
        SetTextScale(0.5,0.5)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(what)
        DrawText(x,y)
    end
end

local function _draw(area,comparePoint)
    if not comparePoint and area.fade ~= 0 then
        if IsGameplayCamRendering() or IsCinematicCamRendering() then
            comparePoint = GetGameplayCamCoord()
        else
            comparePoint = GetCamCoord(GetRenderingCam())
        end
    end


    if #area.points > 2 then
        local alphaFraction = 1.0
        local bR,bG,bB,bA = table.unpack(area.border)
        local wR,wG,wB,wA = table.unpack(area.color)
        local wallAlpha = wA
        local borderAlpha = bA

        if area.fade > 0 and area.wallFade <= 0 then
            local distance = #(area.center - comparePoint)
            alphaFraction = 1.0 - ((1 / area.fade) * distance)
            borderAlpha = math.ceil(bA * alphaFraction)
            borderAlpha = math.max(borderAlpha,0)
            borderAlpha = math.min(borderAlpha,255)

            wallAlpha = math.ceil(wA * alphaFraction)
            wallAlpha = math.max(wallAlpha,0)
            wallAlpha = math.min(wallAlpha,255)
        end

        if wallAlpha > 0 or borderAlpha > 0 or area.wallFade > 0 then
            if area.label then
                local labelAlpha = bA
                if area.fade > 0 then
                    local distance = #(area.center - comparePoint)
                    local alphaFraction = 1.0 - ((1 / area.fade) * distance)
                    labelAlpha = math.ceil(bA * alphaFraction)
                    labelAlpha = math.max(labelAlpha,0)
                    labelAlpha = math.min(labelAlpha,255)
                end
                _drawLabel(area.center,area.label,bR,bG,bB,labelAlpha)
            end
            local lastPoint = nil
            local lastAbove = nil
            local firstPoint = nil
            local firstAbove = nil
            for i,point in ipairs(area.points) do
                local above = point + area.aboveOffset
                if lastPoint then
                    if area.wallFade > 0 then
                        lineDistance = _lineDistanceSquared(point,lastPoint,comparePoint)
                        wallAlpha = (wA/area.wallFade) * (area.wallFade - lineDistance)
                        wallAlpha = math.ceil(wallAlpha)
                        wallAlpha = math.max(0,wallAlpha)
                        wallAlpha = math.min(255,wallAlpha)
                        borderAlpha = (bA/area.wallFade) * (area.wallFade - lineDistance)
                        borderAlpha = math.ceil(borderAlpha)
                        borderAlpha = math.max(0,borderAlpha)
                        borderAlpha = math.min(255,borderAlpha)
                    end
                    if wallAlpha > 0 then
                        _wall(point,above,lastPoint,lastAbove,wR,wG,wB,wallAlpha,comparePoint)
                    end
                    if borderAlpha > 0 then
                        Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, lastPoint,point,bR,bG,bB,borderAlpha)
                        Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, lastAbove,above,bR,bG,bB,borderAlpha)
                        Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, point,above,bR,bG,bB,borderAlpha)
                    end
                else
                    firstAbove = above
                    firstPoint = point
                end
                lastAbove = above
                lastPoint = point
                if area.numbered then
                    local middle = point + (area.aboveOffset / 2)
                    local labelAlpha = bA
                    if area.fade > 0 and area.wallFade <= 0 then
                        local distance = #(area.center - comparePoint)
                        local alphaFraction = 1.0 - ((1 / area.fade) * distance)
                        labelAlpha = math.ceil(bA * alphaFraction)
                    elseif area.wallFade > 0 then
                        local distance = #(comparePoint - middle)
                        distance = distance * distance -- because area.wallFade is squared, remember?
                        local alphaFraction = 1.0 - ((1 / area.wallFade) * distance)
                        labelAlpha = math.ceil(bA * alphaFraction)
                    end
                    labelAlpha = math.max(labelAlpha,0)
                    labelAlpha = math.min(labelAlpha,255)
                    if labelAlpha > 0 then
                        _drawLabel(middle,i,bR,bG,bB,labelAlpha)
                    end
                end
            end
            if area.wallFade > 0 then
                lineDistance = _lineDistanceSquared(lastPoint,firstPoint,comparePoint)
                wallAlpha = (wA/area.wallFade) * (area.wallFade - lineDistance)
                wallAlpha = math.ceil(wallAlpha)
                wallAlpha = math.max(0,wallAlpha)
                wallAlpha = math.min(255,wallAlpha)
                borderAlpha = (bA/area.wallFade) * (area.wallFade - lineDistance)
                borderAlpha = math.ceil(borderAlpha)
                borderAlpha = math.max(0,borderAlpha)
                borderAlpha = math.min(255,borderAlpha)
            end
            if borderAlpha > 0 then
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, lastPoint,firstPoint,bR,bG,bB,borderAlpha)
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, lastAbove,firstAbove,bR,bG,bB,borderAlpha)
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, point,above,bR,bG,bB,borderAlpha)
                Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, firstPoint,firstAbove,bR,bG,bB,borderAlpha)
            end
            if wallAlpha > 0 then
                _wall(lastPoint,lastAbove,firstPoint,firstAbove,wR,wG,wB,wallAlpha,comparePoint)
            end
            return true
        end
    end
    return false
end

local function _recalc(area)
    local totalX = 0.0
    local totalY = 0.0
    local totalZ = 0.0
    local maxX
    local maxY
    local minX
    local minY
    for i,p in ipairs(area.points) do

        if not maxX or p.x > maxX then
            maxX = p.x
        end
        if not maxY or p.y > maxY then
            maxY = p.y
        end
        if not minX or p.x < minX then
            minX = p.x
        end
        if not minY or p.y < minY then
            minY = p.y
        end

        totalX = totalX + p.x
        totalY = totalY + p.y
        totalZ = totalZ + p.z
        if p.z + area.height > area.maxZ then
            area.maxZ = p.z + area.height
        end
        if p.z < area.minZ then
            area.minZ = p.z
        end
    end

    area.max = vector3(maxX,maxY,area.maxZ)
    area.min = vector3(minX,minY,area.minZ)
    area.size = area.max - area.min
    area.center = (area.max + area.min) / 2

    -- Yes, I realize this iterates the points list *twice*
    -- If you have suggestions on ways to avoid this, please make a pull request.
    for i,point in ipairs(area.points) do
        local pointDistance = #( area.center - point)
        if pointDistance > area.radius then
            area.radius = pointDistance
        end
    end
end

local function _add(area,point)
    if type(point) == 'vector3' then
        table.insert(area.points,point)
    end
end


local function _angle(A,B,C)
    local dotProduct = _dotProduct(A,B,C)
    local crossProduct = _crossProduct(A,B,C)
    return math.atan(crossProduct,dotProduct)
end

local function _isInside(area,candidate)

    if #area.points <= 2 then
        return false
    end

    if not candidate then
        candidate = GetEntityCoords(PlayerPedId())
    end

    if type(candidate) == 'vector3' then
        local centerDistance = #( candidate - area.center )
        if centerDistance <= area.radius then
            if candidate.z <= area.maxZ and candidate.z >= area.minZ then
                local first = area.points[1]
                local last = area.points[#area.points]
                local total = _angle(last,candidate,first)
                for i,point in ipairs(area.points) do
                    if i < #area.points then
                        total = total + _angle(point,candidate,area.points[i+1])
                    else
                        total = total + _angle(point,candidate,first)
                    end
                end
                total = math.abs(total)
                return total > area.threshold
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function pArea(spec)
    spec = spec or {}
    local area = {
        height = (spec.height or defaults.height) * 1.0,
        color = spec.color or defaults.color,
        border = spec.border or spec.color or defaults.color,
        fade = (spec.fade or defaults.fade) * 1.0,
        wallFade = (spec.wallFade or defaults.wallFade) * 1.0,
        threshold = spec.threshold or defaults.threshold,
        numbered = spec.numbered or defaults.numbered,
        label = spec.label, -- No default.
        points = {},
        maxZ = -math.huge,
        minZ = math.huge,
        radius = 0.0,
        center = vector3(0,0,0),
        size = vector3(0,0,0),
        max = vector3(0,0,0),
        min = vector3(0,0,0),
    }
    area.wallFade = area.wallFade * area.wallFade -- So we don't have to do a square root on the distance!
    area.aboveOffset = vector3(0.0,0.0,area.height)
    if sanityCheck(area) then
        function area.draw(comparePoint)
            return _draw(area,comparePoint)
        end
        function area.addPoint(point)
            _add(area,point)
            _recalc(area)
        end
        function area.addBulk(...)
            for i,point in ipairs({...}) do
                _add(area,point)
            end
            _recalc(area)
        end
        function area.isInside(candidate)
            return _isInside(area,candidate)
        end
    end
    return area
end

exports('create',pArea)