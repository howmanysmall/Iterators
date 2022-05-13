local Filter = require(script.Filter)
local Range = require(script.Range)
local Zip = require(script.Zip)

--[=[
	A library that implements a lot of custom iterators for Luau.

	@class Iterators
]=]

local Iterators = {
	Filter = Filter;
	Range = Range;
	Zip = Zip;
}

table.freeze(Iterators)
return Iterators
