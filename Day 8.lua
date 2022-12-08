local input

local grid = {}

for row in input:gmatch("([^\n]+)\n") do
	table.insert(grid, row:split(""))
end

local totalVisibleTrees = 0

for rowIndex, trees in ipairs(grid) do
	for treeIndex, treeHeight in ipairs(trees) do
	
		local sidesVisibleFrom = 4
		
		-- Check right
		for otherTreeIndex = treeIndex+1, #trees do
			if trees[otherTreeIndex]-treeHeight >= 0 then
				sidesVisibleFrom -= 1
				break
			end
		end
		
		-- Check left
		for otherTreeIndex = treeIndex-1, 1, -1 do
			if trees[otherTreeIndex]-treeHeight >= 0 then
				sidesVisibleFrom -= 1
				break
			end
		end
		
		-- Check up
		for otherRowIndex = rowIndex-1, 1, -1 do
			if grid[otherRowIndex][treeIndex]-treeHeight >= 0 then
				sidesVisibleFrom -= 1
				break
			end
		end
		
		-- Check down
		for otherRowIndex = rowIndex+1, #grid do
			if grid[otherRowIndex][treeIndex]-treeHeight >= 0 then
				sidesVisibleFrom -= 1
				break
			end
		end

		totalVisibleTrees += math.sign(sidesVisibleFrom)
	end
end

print(totalVisibleTrees)

-- PART 2 --

local grid = {}

for row in input:gmatch("([^\n]+)\n") do
	table.insert(grid, row:split(""))
end

local bestScenicScore = 0

for rowIndex, trees in ipairs(grid) do
	for treeIndex, treeHeight in ipairs(trees) do
	
		local scenicScore = {0, 0, 0, 0}
		
		-- Check right
		for otherTreeIndex = treeIndex+1, #trees do
			scenicScore[1] += 1
			
			if trees[otherTreeIndex]-treeHeight >= 0 then
				break
			end
		end
		
		-- Check left
		for otherTreeIndex = treeIndex-1, 1, -1 do
			scenicScore[2] += 1
			
			if trees[otherTreeIndex]-treeHeight >= 0 then
				break
			end
		end
		
		-- Check up
		for otherRowIndex = rowIndex-1, 1, -1 do
			scenicScore[3] += 1
			
			if grid[otherRowIndex][treeIndex]-treeHeight >= 0 then
				break
			end
		end
		
		-- Check down
		for otherRowIndex = rowIndex+1, #grid do
			scenicScore[4] += 1
			
			if grid[otherRowIndex][treeIndex]-treeHeight >= 0 then
				break
			end
		end
		
		scenicScore = scenicScore[1] * scenicScore[2] * scenicScore[3] * scenicScore[4]
		
		if scenicScore > bestScenicScore then
			bestScenicScore = scenicScore
		end
	end
end

print(bestScenicScore)
