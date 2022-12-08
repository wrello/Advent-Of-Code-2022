local input

local str = ""

local i = 0

for char in input:gmatch("%a") do
	i = i + 1

	str = str .. char

	if #str == 14 then -- Only difference between Part 1 and Part 2
		local found = false

		for j = 1, #str do
			local rest = str:sub(j+1, #str)

			if rest:match(str:sub(j, j)) then
				found = true
				break
			end
		end

		str = str:gsub("^%a", "")

		if not found then
			print(i)
			break
		end
	end
end
