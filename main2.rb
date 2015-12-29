require './variables.rb'
require './math.rb'
require './text.rb'
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
set d to -20 + 3

puts d is divisible by d-(5+13)
puts d is divisible by d*2
puts d is divisible by 7
puts d is divisible by 2
puts d is odd

set d to square root 16
puts 7^2
puts d + 1
puts square root of (d + 1)
puts sqrt(d + 1)
puts square root of 4 + 1
puts Math.sqrt 4 + 1
puts absolute -d

if not d is prime then
	puts "NEGATIVE"
end

if d^2 < 0 then
	puts "POSITIVE"
end

puts 12.0 === 12

#puts d+=1

set abc to -425.5
#puts abc is divisible by 5
puts abc
puts (abc + 125).to_f
set t to 15
set t to t * t + 5
puts t
puts *[10,5]
puts 2.5.class

a = 0
if a < 5 then
	a += 1
	puts a
end

set perfectNumStr to "The perfect numbers from 2 to 100 are as follows: "
#puts "-----"
for numbers in 2..100 do
	set sum to 1
	set num to numbers
	for d in 2..(square root numbers) do
		if num is divisible by d and d != (square root numbers) then
			#puts "D: #{num}, #{d}, #{square root num}"
			increase sum by d + numbers / d
		elsif num is divisible by d then
			increase sum by d
		end
	end
	#puts "#{num} : #{sum}"
	if sum == num then
		set perfectNumStr to perfectNumStr + numbers.to_s + ", "
	end
end

puts perfectNumStr
set d to 15
#p 5.is
p 20.is divisible by d



set b to square root 9
increase b by absolute -12 # added instruction
puts b

if b is divisible by 10 then
  print "d is divisible by 10"
elsif b is even then 
  print "d is even"
elsif b is divisible by 5
  print "d is divisible by 5" # this is what's printed for above example
else
  print "d is odd and not divisible by 5"
end


set m to square root 9
increase m by absolute -12 # increase was used as an added instruction: d now evaluates to 15

if m is divisible by 10 then
  print "m is divisible by 10"
elsif m is even then
  print "m is even"
elsif m is divisible by 5
  print "m is divisible by 5" # this 
else
  print "m is odd and not divisible by 5"
end

set str to "abcdefgde"
#str = "abcdefg"
puts "\n---"
puts from str get letter length of str
puts from "abcdefgde".get letter length of str
puts length of str
puts length of "abcdefgde"
puts from text str get substring from letter 3, (length of str)
puts from text "abcdefgde".get substring from letter 3, (length of str) 
puts from text str find first occurrence of text "de"
puts from text "abcdefgde".find first occurrence of text "de"
puts from text str find last occurrence of text "de"
puts from text "abcdefgde".find last occurrence of text "de"
#puts str.index("d")
puts "---"

set a to 58
set b to remainder of a divided by 10
puts remainder of a divided by b - 2
puts (prompt to get number with message "Enter something interesting: ") + 5
set number to remainder of a divided by 20
puts "*******"
puts number
puts "*******"

(b-5).times do 
	puts "abc"
end

b.times do 
	puts "def"
end

#puts for(5)


#def count i, start, stop, &b
#	for j in start..stop do
#		yield j
#	end
#end

def count a
end

def i a
end

def withs a
end

def froms start, stop, &block
	for m in start..stop do
		yield m
	end
end

count withs i (froms 1, 5 do |i|
	puts i
end)
