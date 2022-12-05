local input

local lowerByteOffset = -(97 - 1)
local upperByteOffset = -(65 - 27)

local function findDuplicate(line)
    local firstHalf = line:match("(" .. ("%a"):rep(math.floor(#line/2)) .. ").*")
    local secondHalf = line:gsub(firstHalf, "")
    
    for char in firstHalf:gmatch("%a") do
        if secondHalf:find(char) then
            return char
        end
    end
end

local total = 0

for line in input:gmatch("(%a+)\n") do
    local duplicate = findDuplicate(line)
    local val = duplicate:byte() + (duplicate:match("%l") and lowerByteOffset or upperByteOffset)
    
    -- print(duplicate, "found in both halves with a value of", val)
    
    total = total + val
end

print(total)

-- PART 2 --

local lowerByteOffset = -(97 - 1)
local upperByteOffset = -(65 - 27)

local function findDuplicate(line1, line2, line3)
    for char in line1:gmatch("%a") do
        if line2:find(char) and line3:find(char) then
            return char
        end
    end
end

local total = 0

for line1, line2, line3 in input:gmatch(("(%a+)\n"):rep(3)) do
    local duplicate = findDuplicate(line1, line2, line3)
    local val = duplicate:byte() + (duplicate:match("%l") and lowerByteOffset or upperByteOffset)
    
    -- print(duplicate, "found in both halves with a value of", val)
    
    total = total + val
end

print(total)