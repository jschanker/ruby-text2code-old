require './variables.rb'
require './math.rb'
require './proxy.rb'

set d to 1.23
increase d by 8.77
puts d
multiply d by 5
puts d
divide d by 10
puts d
decrease d by 4
puts (50 + 2*d + 50)**2
set d to d + 1
puts d
puts (50 + 2*d + 50)**2
puts (d+1)**d
set d to 20

puts d is divisible by d-(5+13)
puts d is divisible by d*2
puts d is divisible by 7
puts d is divisible by 2

set abc to -425.5
#puts abc is divisible by 5
puts abc
puts (abc + 125).to_f
set t to 15
set t to t * t + 5
puts t
puts *[10,5]
puts 2.5.class
