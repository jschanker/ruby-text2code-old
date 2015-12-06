class Mutablenum
	attr_accessor :num
	def initialize(n = 0)
		@num = n
	end
	def increase m
		@num += m
	end
	def decrease m
		@num -= m
	end
	def multiply m
		@num *= m
	end
	def divide m
		@num /= m
	end
	def set m
		@num = m
	end
	def to_i
		puts "Here"
		@num.to_i
	end
	def to_ary
		@num.to_ary
	end
	def to_s
		@num.to_s
	end
	def + m
		puts "Here"
		return @num.+ m
	end
	def - m
		@num.- m
	end
	def * m
		@num.* m
	end
	def / m
		@num./ m
	end
	def ** m
		@num.** m
	end
	def method_missing(name, *args)
		@num.send(name,args)
	end
end

class Fixnum
	#def is(op, arg=nil)
	#	if(op == "div") then
	#		self % arg == 0
	#end
	def is(arr)
		#puts "Here " + self.to_s
		if(arr[0] == "div") then
			return self % arr[1] == 0
		end
		if(arr.length == 1 and arr[0].class == Array and arr[0][0] == "div") then
			return self % arr[0][1] == 0
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