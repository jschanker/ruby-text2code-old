class Fixnum
	#def is(op, arg=nil)
	#	if(op == "div") then
	#		self % arg == 0
	#end
	def is(arr)
		if(arr[0] == "div") then
			self % arr[1] == 0
		end
	end

	def divisible(d)
		self % d == 0
	end
end

def is x
	
end

def divisible d
	["div", d]
end

def by d
	d
end