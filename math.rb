class Fixnum
	#def is(op, arg=nil)
	#	if(op == "div") then
	#		self % arg == 0
	#end
	def is(arr)
		#puts "Here " + self.to_s
		if(arr[0] == "div") then
			self % arr[1] == 0
		end
	end

	def divisible(d)
		self % d == 0
	end

	def by(d)
		[:x, d, binding]
	end

	def method_missing(d)
		puts "#{d} Method missing"
	end
end

def increase(arr)
  eval "#{arr[0]} = #{arr[0]} + #{arr[1]}", arr[2]
end

def is x
	x
end

def divisible d
	["div", d]
end

def by d
	d
end