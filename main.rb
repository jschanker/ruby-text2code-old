require './math.rb'
require './variables.rb'
require './logic.rb'
require './text.rb'

require './proxy.rb'

class Variables
	def method_missing(m, arr=nil)
	end
end

@asd = "Y variable"
puts local_variables

Variable.x 425
Variable.x.increase by 2
puts Variable.x.to_s
puts Variable.x.is divisible by 7

class Food
	self.attr_accessor :vf
	@vf = 56
	def self.foo n=nil
		if(n == nil) then
			puts "Foo function"
			return @foo
		end

		@foo = n
		return @foo
	end

	def self.foo= n
		puts "FOOoOOO"
		print self.vf
		return @vf
	end
end

#f = Food.new
#puts f.foo "FOO VALUE"
#puts f.foo
#f.foo = "NO FOO VALUE"
#puts f.foo
print Food.foo = 125
puts Food.foo
puts Food.vf

#puts Food.methods

a = Mutablenum.new(4)
a = a + 5
print a

#puts self.class
let x = 45
let y = 7
puts x.is divisible by 7

let s = "abcdefcdeg"
puts s.get letter length of s
puts s.get substring from 3 , (length of s)
print s.find first occurrence of "cde"
print s.find last occurrence of "cde"
print length of s

puts
#d = set z to 15
#set z to 25
set z to 4
#z = z + 3
z = (z+3)
#z.set 54
#z.increase by 5
#z.decrease by 3
#z.multiply by 2
#z.divide by 2
puts
puts
#z = z + 5
print z.class
puts
puts
#p z
#p z / 2
#p z
#puts "#{z}"
#puts "#{z.num}"
#print self.class
#puts "#{z.to_i}"
#set z 15
#set z to 80
#set z to 100
#print Object.z
#puts d.inspect
#print z
#set z to 10
print z.is divisible by 5 