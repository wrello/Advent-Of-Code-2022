local input

local oppKey = {
    A = 1,
    B = 2,
    C = 3
}

local myKey = {
    X = 1,
    Y = 2,
    Z = 3
}

local diffKey = {
    ["0"] = 3,
    ["1"] = 0,
    ["2"] = 6,
    ["-1"] = 6,
    ["-2"] = 0
}

local total = 0

for opp, my in input:gmatch("(%w) (%w)\n") do
    local myPoints = myKey[my]
    local oppPoints = oppKey[opp]
    local diff = oppPoints-myPoints
    local diffPoints = diffKey[tostring(diff)]

    total = total + myPoints + diffPoints
end

print(total)

-- PART 2 --

local oppKey = {
    A = 1,
    B = 2,
    C = 3
}

local myKey = {
    X = 1,
    Y = 2,
    Z = 3
}

local shapeToResultKey = {
    X = -2, -- Lose
    Y = 0, -- Draw
    Z = -1 -- Win
}

local resultToWinPointsKey = {
    ["0"] = 3,
    ["1"] = 0,
    ["2"] = 6,
    ["-1"] = 6,
    ["-2"] = 0
}

local function getRequiredShape(oppShape, myShape)
    local requiredDiff = oppKey[oppShape] - shapeToResultKey[myShape]
    local mod = requiredDiff%3

    if mod == 0 then
        mod = 3
    end
    
    for shape, v in pairs(myKey) do
        if v == mod then
            myShape = shape
        end
    end
    
    return myShape
end

local total = 0

for opp, my in input:gmatch("(%w) (%w)\n") do
    local newMy = getRequiredShape(opp, my)
    
    local myPoints = myKey[newMy]
    local oppPoints = oppKey[opp]
    local result = oppPoints-myPoints
    local winPoints = resultToWinPointsKey[tostring(result)]

    total = total + myPoints + winPoints
end

print(total)