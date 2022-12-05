local input

local currentElf = 0

local max = 0

for line in input:gmatch("(.-)\n") do
    if line:find("%d") then
        currentElf = currentElf + tonumber(line)
    else
        if currentElf > max then
            max = currentElf
        end
        
        currentElf = 0
    end
end

print(max)

-- PART 2 --

local elves = {0}

local currentElf = 0

for line in input:gmatch("(.-)\n") do
    if line:find("%d") then
        currentElf = currentElf + tonumber(line)
    else
        table.insert(elves, 1, currentElf)
        
        currentElf = 0
    end
end

local function unpack(t, i)
    i = i or 1
    
    local v = t[i]
    
    if v ~= nil then
        return v, unpack(t, i+1)
    else
        return
    end
end

table.find = function(haystack, needle)
    for i, v in pairs(haystack) do
        if v == needle then
            return i
        end
    end

    return nil
end

local function getNextMax()
    local nextMax = math.max(unpack(elves))
    
    table.remove(elves, table.find(elves, nextMax))
    
    return nextMax
end

print(getNextMax() + getNextMax() + getNextMax())