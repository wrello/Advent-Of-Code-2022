local input

local function isContainedBy(rangeMin, rangeMax, containerRangeMin, containerRangeMax)
    return tonumber(rangeMin) >= tonumber(containerRangeMin) and tonumber(rangeMax) <= tonumber(containerRangeMax)
end

local total = 0

for rangeMin1, rangeMax1, rangeMin2, rangeMax2 in input:gmatch("(%d+)-(%d+),(%d+)-(%d+)") do
    if isContainedBy(rangeMin1, rangeMax1, rangeMin2, rangeMax2) or isContainedBy(rangeMin2, rangeMax2, rangeMin1, rangeMax1) then
        total = total + 1
    end
end

print(total)

-- PART 2 --

local function isOverlapping(rangeMin1, rangeMax1, rangeMin2, rangeMax2)
    local biggerSize = math.max(rangeMax1-rangeMin1, rangeMax2-rangeMin2)
    local biggerDist = math.max(math.abs(rangeMax2-rangeMax1), math.abs(rangeMin2-rangeMin1))
    
    return biggerDist <= biggerSize
end

local total = 0

for rangeMin1, rangeMax1, rangeMin2, rangeMax2 in input:gmatch("(%d+)-(%d+),(%d+)-(%d+)") do
    if isOverlapping(rangeMin1, rangeMax1, rangeMin2, rangeMax2) then
        total = total + 1
    end
end

print(total)