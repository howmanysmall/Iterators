--[=[
	A reimplementation of [zip](https://docs.python.org/3/library/functions.html#zip) from Python.

	```lua
	-- Both of these should print:
	-- 1 A
	-- 2 B
	-- 3 C

	for ValueA, ValueB in Zip({1, 2, 3}, {"A", "B", "C"}) do
		print(ValueA, ValueB)
	end

	for ValueA, ValueB in Zip(Range(1, 4), {"A", "B", "C"}) do
		print(ValueA, ValueB)
	end
	```

	@function Zip<T, U>
	@param ListOrIteratorA {T} | () -> T -- The first array or iterator to zip.
	@param ListOrIteratorB {U} | () -> U -- The second array or iterator to zip.
	@param Strict boolean? -- Whether to throw an error if the arrays are not the same length.
	@return () -> (T, U)
	@within Iterators
]=]
local function Zip<T, U>(ListOrIteratorA: {T} | () -> T, ListOrIteratorB: {U} | () -> U, Strict: boolean?)
	local TypeA = type(ListOrIteratorA)
	local ListA = if TypeA == "table"
		then ListOrIteratorA
		elseif TypeA == "function" then {}
		else error("ListOrIteratorA must be an array or an iterator.", 2)

	if TypeA == "function" then
		local Length = 0
		for Value in ListOrIteratorA do
			Length += 1
			ListA[Length] = Value
		end
	end

	local TypeB = type(ListOrIteratorB)
	local ListB = if TypeB == "table"
		then ListOrIteratorB
		elseif TypeB == "function" then {}
		else error("ListOrIteratorB must be an array or an iterator.", 2)

	if TypeB == "function" then
		local Length = 0
		for Value in ListOrIteratorB do
			Length += 1
			ListB[Length] = Value
		end
	end

	local LengthA = #ListA
	local LengthB = #ListB
	if Strict and LengthA ~= LengthB then
		error(
			"Error in Zip: "
				.. if LengthA < LengthB
					then "argument 2 is longer than argument 1"
					else "argument 1 is longer than argument 2",
			2
		)
	end

	local StopAt = math.min(LengthA, LengthB)
	local Index = 0

	return function()
		Index += 1
		if Index <= StopAt then
			return ListA[Index], ListB[Index]
		end
	end
end

return Zip
