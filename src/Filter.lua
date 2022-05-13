--[=[
	A reimplementation of [filter](https://docs.python.org/3/library/functions.html#filter) from Python.

	You can filter an array:
	```lua
	-- This should print:
	-- 18
	-- 24
	-- 32
	local function FilterAge(Age: number)
		return Age >= 18
	end

	for Age in Filter(FilterAge, {5, 12, 17, 18, 24, 32}) do
		print(Age)
	end
	```

	You can also use an iterator like [Range](#Range):
	```lua
	-- This should print:
	-- 2
	-- 4
	-- 6
	-- 8
	local function FilterEvens(Value: number)
		return Value % 2 == 0
	end

	for Value in Filter(FilterEvens, Range(1, 10)) do
		print(Value)
	end
	```

	@function Filter<T>
	@param FilterFunction (Value: T) -> boolean -- The function to filter with.
	@param ListOrIterator {T} | () -> T -- The iterator or array to filter.
	@return () -> T
	@within Iterators
]=]
local function Filter<T>(FilterFunction: (Value: T) -> boolean, ListOrIterator: {T} | () -> T)
	local Type = type(ListOrIterator)
	local FilteredList = {}
	local Length = 0

	if Type == "function" then
		for Value in ListOrIterator do
			if FilterFunction(Value) then
				Length += 1
				FilteredList[Length] = Value
			end
		end
	elseif Type == "table" then
		for _, Value in ipairs(ListOrIterator :: {T}) do
			if FilterFunction(Value) then
				Length += 1
				FilteredList[Length] = Value
			end
		end
	else
		error("ListOrIterator must be an array or an iterator.", 2)
	end

	local Index = 0
	return function()
		Index += 1
		if Index <= Length then
			return FilteredList[Index]
		end
	end
end

return Filter
