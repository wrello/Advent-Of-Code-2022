local input

local stacks = {}

local function moveFromTo(num, from, to)
    num, from, to = tonumber(num), tonumber(from), tonumber(to)
    
    for i = 1, num do
        table.insert(stacks[to], stacks[from][#stacks[from]])
        table.remove(stacks[from], #stacks[from])
    end
end

local stackIndex = 0
local reversedStacks = false

for line in input:gmatch("([^\n]+)\n") do
   stackIndex = 0
    
    if line:match("move") then
        if not reversedStacks then
            reversedStacks = true
            for i, stack in ipairs(stacks) do
                rev = {}
                for i=#stack, 1, -1 do
                	rev[#rev+1] = stack[i]
                end
                stacks[i] = rev
            end

            for _, stack in ipairs(stacks) do
                local list = ""
               for _, v in ipairs(stack) do
                   list = list .. v
                end
                -- print(list)
            end
            
        end
        
        moveFromTo(line:match("move (%d+) from (%d+) to (%d+)"))
    else
        for char in line:gmatch("(...) ?") do
            stackIndex = stackIndex + 1
           
            if not stacks[stackIndex] then
               stacks[stackIndex] = {}
            end
            
            -- print("inserting into stack", stackIndex, "char", char)
            
            if char:match("%a") then
                -- print("inserting", char, "into stack", stackIndex)
            table.insert(stacks[stackIndex], char)
            end
        end
    end
end

local s = ""

for _, stack in ipairs(stacks) do
    s = s .. stack[#stack]
end

print(s)

-- PART 2 --

local stacks = {}

local function unpack(t, i)
    if t[i] == nil then
        return
    end
    
   return t[i], unpack(t, i+1)
end

local function moveFromTo(num, from, to)
    num, from, to = tonumber(num), tonumber(from), tonumber(to)
    
    local sameOrder = {}
    
    for i = 1, num do
        table.insert(sameOrder, stacks[from][#stacks[from]])
        table.remove(stacks[from], #stacks[from])
    end

rev = {}
                for i=#sameOrder, 1, -1 do
                	rev[#rev+1] = sameOrder[i]
                end
               sameOrder = rev

    for _, v in ipairs(sameOrder) do
        table.insert(stacks[to], v) 
    end
end

local stackIndex = 0
local reversedStacks = false

for line in input:gmatch("([^\n]+)\n") do
   stackIndex = 0
    
    if line:match("move") then
        if not reversedStacks then
            reversedStacks = true
            for i, stack in ipairs(stacks) do
                rev = {}
                for i=#stack, 1, -1 do
                	rev[#rev+1] = stack[i]
                end
                stacks[i] = rev
            end

            for _, stack in ipairs(stacks) do
                local list = ""
               for _, v in ipairs(stack) do
                   list = list .. v
                end
                -- print(list)
            end
            
        end
        
        moveFromTo(line:match("move (%d+) from (%d+) to (%d+)"))
    else
        for char in line:gmatch("(...) ?") do
            stackIndex = stackIndex + 1
           
            if not stacks[stackIndex] then
               stacks[stackIndex] = {}
            end
            
            -- print("inserting into stack", stackIndex, "char", char)
            
            if char:match("%a") then
                -- print("inserting", char, "into stack", stackIndex)
            table.insert(stacks[stackIndex], char)
            end
        end
    end
end

local s = ""

for _, stack in ipairs(stacks) do
    s = s .. stack[#stack]:match("%a")
end

print(s)