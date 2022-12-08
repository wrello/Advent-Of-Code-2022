local input

local filesystem = {
	["/"] = {}
}

local currentDirectory, currentPath = nil, ""

local function getOrDefaultFromPath(path, parent)
	local childName = path:match("^([^%.]*)")
	
	if #childName > 0 then
		return getOrDefaultFromPath(path:gsub("^" .. childName .. "%.?", ""), parent[childName])
	else
		return parent
	end
end

local function getDirectoryTotalSize(directory)
	local totalSize = 0

	for _, fileSize in pairs(directory) do
		if type(fileSize) == "table" then
			local directory = fileSize

			totalSize += getDirectoryTotalSize(directory)
		else
			totalSize += fileSize
		end
	end

	return totalSize
end

for line in input:gmatch("([^\n]+)\n") do
	if line == "$ ls" then
		currentDirectory = getOrDefaultFromPath(currentPath, filesystem, {})
		continue
	elseif line:match("^$ cd") then
		if line:find("%.%.") then
			currentPath = currentPath:gsub("%.[^%.]+$", "") -- Remove a child from the path
		else
			local newChildName = line:match("%$ cd (.+)")

			-- Add a child to the path
			if currentPath == "" then
				currentPath ..= newChildName
			else
				currentPath ..= "." .. newChildName
			end
		end
	else
		local childDirName = line:match("dir (.+)")
		
		if childDirName then
			currentDirectory[childDirName] = {} -- Add a directory
		else
			local size, childFileName = line:match("(%d+) (.+)")
			
			childFileName = childFileName:gsub("%.", "")
			
			currentDirectory[childFileName] = tonumber(size) -- Add a file
		end
	end
end

local sumOfTotalSizes = 0

local function getSumOfTotalSizesUnder100000(directory)
	for dirName, directory in pairs(directory) do
		if type(directory) == "table" then
			local totalSize = getDirectoryTotalSize(directory)
			
			if totalSize < 100000 then
				sumOfTotalSizes += totalSize
			end
			
			getSumOfTotalSizesUnder100000(directory)
		end
	end
end

getSumOfTotalSizesUnder100000(filesystem)

print(sumOfTotalSizes)

-- PART 2 --

local filesystem = {
	["/"] = {}
}

local currentDirectory, currentPath = nil, ""

local function getOrDefaultFromPath(path, parent)
	local childName = path:match("^([^%.]*)")
	
	if #childName > 0 then
		return getOrDefaultFromPath(path:gsub("^" .. childName .. "%.?", ""), parent[childName])
	else
		return parent
	end
end

local function getDirectoryTotalSize(directory)
	local totalSize = 0

	for _, fileSize in pairs(directory) do
		if type(fileSize) == "table" then
			local directory = fileSize

			totalSize += getDirectoryTotalSize(directory)
		else
			totalSize += fileSize
		end
	end

	return totalSize
end

for line in input:gmatch("([^\n]+)\n") do
	if line == "$ ls" then
		currentDirectory = getOrDefaultFromPath(currentPath, filesystem, {})
		continue
	elseif line:match("^$ cd") then
		if line:find("%.%.") then
			currentPath = currentPath:gsub("%.[^%.]+$", "") -- Remove a child from the path
		else
			local newChildName = line:match("%$ cd (.+)")

			-- Add a child to the path
			if currentPath == "" then
				currentPath ..= newChildName
			else
				currentPath ..= "." .. newChildName
			end
		end
	else
		local childDirName = line:match("dir (.+)")
		
		if childDirName then
			currentDirectory[childDirName] = {} -- Add a directory
		else
			local size, childFileName = line:match("(%d+) (.+)")
			
			childFileName = childFileName:gsub("%.", "")
			
			currentDirectory[childFileName] = tonumber(size) -- Add a file
		end
	end
end

local totalUsedSpace = getDirectoryTotalSize(filesystem["/"])
local totalUnusedSpace = 70000000 - totalUsedSpace

local amountToFree = 30000000 - totalUnusedSpace

local minTotalSizeMoreThanAmountToFree = math.huge

local function getMinDirectoryTotalSizeMoreThanAmountToFree(directory)
	for dirName, directory in pairs(directory) do
		if type(directory) == "table" then
			local totalSize = getDirectoryTotalSize(directory)
			
			if totalSize >= amountToFree and totalSize < minTotalSizeMoreThanAmountToFree then
				minTotalSizeMoreThanAmountToFree = totalSize
			end
			
			getMinDirectoryTotalSizeMoreThanAmountToFree(directory)
		end
	end
end

getMinDirectoryTotalSizeMoreThanAmountToFree(filesystem["/"])

print(minTotalSizeMoreThanAmountToFree)