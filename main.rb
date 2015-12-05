require './math.rb'
require './variables.rb'
require './logic.rb'
require './text.rb'

#module A

	#def A::method_missing(m, arr=nil)
	def method_missing(m, arr=nil)
		if(arr.class == Array and arr[0] == "div") then
			return "#{m}".to_i.is divisible by arr[1]
			#puts local_variables
			#eval("puts .to_s")
			#puts caller.local_variables
			#puts local_variables.select{|v|v=~/^m/}
		end
	    #puts "No #{m} #{n}, so I'll make one..."
	end

	#puts $x
	let x = 45
	#X = X + 1
	let y = 7
	#puts local_variables
	puts x.is divisible by 7
	#increase x.by 5
	#puts x.foo
	puts x is divisible by 5
	puts x.to_s

#end

#def increase(x, y, bdg)
#  eval "#{x} += #{y}", bdg
#end

#increase :x, 5, binding
#puts x

#def x y
#	5
#end

#begin
#    let x = 42
#    print x is divisible by 7
#    print "reached here"
#rescue NoMethodError => t
#	str = t.to_s
#	puts str[str.index("`")+1..str.index("'")-1]
#end