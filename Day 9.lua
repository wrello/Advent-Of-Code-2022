local input

local grid = {}

local dirToSign = {R = 1, L = -1, U = 1, D = -1}

local sizeX, sizeY = 1, 1
local currentHeadX, currentHeadY = 1, 1

local numUniqueVisitedPositions = 0

local headVisitedPositions = {{1, 1}}

local function markTailVisitedPosition(x, y)
	x += sizeX
	y += sizeY
	
	y = #grid-y
	
	if grid[y][x] == false then
		grid[y][x] = true
		numUniqueVisitedPositions += 1
	end
end

local function visualize(headX, headY, tailX, tailY)
	headY = #grid-headY+1
	tailY = #grid-tailY+1
	
	for y, row in ipairs(grid) do
		local rowStr = ""
		
		for x in ipairs(row) do
			rowStr ..= (headY==y and headX==x and "H") or (tailY==y and tailX==x and "T") or "."
		end
		
		print(rowStr .. #grid-y+1)
	end
	print()
end

-- Get the size of the grid
for dir, step in input:gmatch("(%a) (%d+)\n") do
	local sign = dirToSign[dir]
	local signedStep = step*sign
	
	if dir == "L" or dir == "R" then
		for i = 1, step do
			table.insert(headVisitedPositions, {currentHeadX + i*sign, currentHeadY})
		end
		
		currentHeadX += signedStep
	else
		for i = 1, step do
			table.insert(headVisitedPositions, {currentHeadX, currentHeadY + i*sign})
		end
		
		currentHeadY += signedStep
	end
	
	if math.abs(currentHeadY) > sizeY then
		sizeY = math.abs(currentHeadY)
	end
	
	if math.abs(currentHeadX) > sizeX then
		sizeX = math.abs(currentHeadX)
	end
end

-- Create the grid
for rowIndex = 1, sizeY*2 do
	table.insert(grid, table.create(sizeX*2, false))
end

local currentTailX, currentTailY = 1, 1

for _, headVisitedPos in ipairs(headVisitedPositions) do
	local headX, headY = unpack(headVisitedPos)
	
	local xDiff = headX - currentTailX
	local yDiff = headY - currentTailY

	local xDist = math.abs(xDiff)
	local yDist = math.abs(yDiff)
	
	local xDiffSign = math.sign(xDiff)
	local yDiffSign = math.sign(yDiff)
	
	if xDist == 2 and yDist == 0 then -- Head is: Two over, Zero up
		currentTailX += xDiffSign
	elseif yDist == 2 and xDist == 0 then -- Head is: Two up, Zero over
		currentTailY += yDiffSign
	elseif yDist == 2 and xDist == 1 or yDist == 1 and xDist == 2 then -- Head is: Two up, One over OR One up, Two over
		currentTailX += xDiffSign
		currentTailY += yDiffSign
	end
	
	--visualize(headX, headY, currentTailX, currentTailY)
	
	markTailVisitedPosition(currentTailX, currentTailY)
end

print(numUniqueVisitedPositions)

-- PART 2 --

local grid = {}

local dirToSign = {R = 1, L = -1, U = 1, D = -1}

local sizeX, sizeY = 1, 1
local currentHeadX, currentHeadY = 1, 1

local numUniqueVisitedPositions = 0

local headVisitedPositions = {{1, 1}}

local function markTailVisitedPosition(x, y)
	x += sizeX
	y += sizeY
	
	y = #grid-y+1
	
	if grid[y][x] == false then
		grid[y][x] = true
		numUniqueVisitedPositions += 1
	end
end

local function visualizeGrid()
	local knots = 0
	
	local rowStrings = {}
	
	for i = 1, sizeY*2 do
		table.insert(rowStrings, table.create(sizeX*2, "."))
	end
	
	return function(knotName, knotX, knotY)
		knotX += sizeX
		knotY += sizeY

		knotY = #rowStrings-knotY
		
		rowStrings[knotY+1][knotX] = knotName
		
		knots += 1
		
		if knots == 10 then
			for i, rowStr in ipairs(rowStrings) do
				print(table.concat(rowStr) .. i)
			end
			print()
		end
	end
end

local function adjustTailPos(aheadTailPos, tailCurrentPos)
	local xDiff = aheadTailPos[1] - tailCurrentPos[1]
	local yDiff = aheadTailPos[2] - tailCurrentPos[2]

	local xDist = math.abs(xDiff)
	local yDist = math.abs(yDiff)

	local xDiffSign = math.sign(xDiff)
	local yDiffSign = math.sign(yDiff)

	if xDist == 2 and yDist == 0 then -- Ahead is: Two over, Zero up
		tailCurrentPos[1] += xDiffSign
	elseif yDist == 2 and xDist == 0 then -- Ahead is: Two up, Zero over
		tailCurrentPos[2] += yDiffSign
	elseif yDist > 1 and xDist >= 1 or yDist >= 1 and xDist > 1 then -- Ahead is: Two up, One over OR One up, Two over
		tailCurrentPos[1] += xDiffSign
		tailCurrentPos[2] += yDiffSign
	end
end

-- Get the size of the grid
for dir, step in input:gmatch("(%a) (%d+)\n") do
	local sign = dirToSign[dir]
	local signedStep = step*sign
	
	if dir == "L" or dir == "R" then
		for i = 1, step do
			table.insert(headVisitedPositions, {currentHeadX + i*sign, currentHeadY})
		end
		
		currentHeadX += signedStep
	else
		for i = 1, step do
			table.insert(headVisitedPositions, {currentHeadX, currentHeadY + i*sign})
		end
		
		currentHeadY += signedStep
	end
	
	if math.abs(currentHeadY) > sizeY then
		sizeY = math.abs(currentHeadY)
	end
	
	if math.abs(currentHeadX) > sizeX then
		sizeX = math.abs(currentHeadX)
	end
end

-- Create the grid
for i = 1, sizeY*2 do
	table.insert(grid, table.create(sizeX*2, false))
end

local tailCurrentPositions = {}

for i = 1, 9 do
	table.insert(tailCurrentPositions, table.create(2, 1))
end

for _, headVisitedPos in ipairs(headVisitedPositions) do
	adjustTailPos(headVisitedPos, tailCurrentPositions[9])

	for tailIndex = 8, 1, -1 do
		adjustTailPos(tailCurrentPositions[tailIndex+1], tailCurrentPositions[tailIndex])

		if tailIndex == 1 then
			markTailVisitedPosition(unpack(tailCurrentPositions[tailIndex]))
		end
	end
	
	--local visualize = visualizeGrid()
	
	--for i = 1, 9 do
	--	visualize(10-i, unpack(tailCurrentPositions[i]))
	--end
	
	--visualize("H", unpack(headVisitedPos))
end

print(numUniqueVisitedPositions)