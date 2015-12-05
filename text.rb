class String
	def get arr
		if(arr.class == Array and arr[0] == "char") then
			return self[arr[1]-1]
		end
		if(arr.class == Array and arr[0] == "substr") then
			return self[arr[1]-1..arr[2]-1]
		end
	end

	def find arr
		if(arr.class == Array and arr[0] == "first") then
			return self.index(arr[1])+1
		end
		if(arr.class == Array and arr[0] == "last") then
			return self.rindex(arr[1])+1
		end
	end

	def letterAtPos d
		puts self
		puts d.to_s
		self[d]
	end
end

def length s
	return s.length
end

def of s
	s
end

def first arr
	if(arr.class == Array and arr[0] == "find") then
		["first", arr[1]]
	end
end

def last arr
	if(arr.class == Array and arr[0] == "find") then
		["last", arr[1]]
	end
end

def occurrence sub
	["find", sub]
end

def substring arr
	["substr"].concat(arr)
end

def from start, stop
	[start, stop]
end

def letter d
	["char", d]
end