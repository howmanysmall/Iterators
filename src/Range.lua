--[=[
	A reimplementation of [range](https://docs.python.org/3/library/functions.html#func-range) from Python.

	You can iterate normally:
	```lua
	local Indices = {}
	for Index in Range(0, 5) do
		table.insert(Indices, Index)
	end

	print(table.concat(Indices, ", ")) -- 0, 1, 2, 3, 4
	```

	You can use a custom step as well:
	```lua
	local Indices = {}
	for Index in Range(0, 5, 2) do
		table.insert(Indices, Index)
	end

	print(table.concat(Indices, ", ")) -- 0, 2, 4
	```

	@function Range
	@param Start number -- The starting value of the iterator.
	@param Finish number -- The ending value of the iterator.
	@param Step number? -- The step to increase by. Defaults to 1.
	@return () -> number
	@within Iterators
]=]
local function Range(Start: number, Finish: number, Step: number?)
	local TrueStep = if Step then Step else 1
	Finish -= TrueStep

	local Index = Start
	local OnFirst = true

	return function()
		if OnFirst then
			OnFirst = false
			return Index
		end

		if Index < Finish then
			Index += TrueStep
			return Index
		end
	end
end

return Range
