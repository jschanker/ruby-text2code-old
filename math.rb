class MutableNum
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

	def to_s
		#return @num
		return @num.to_s # why is to_s needed to avoid #<MutableNum:...> display?
	end

	def method_missing(name, *args)
		#puts name
		#puts 42.send(name, 10)
		#puts send(:name, args)
		return self.num.send(name, *args)
	end

	'''
	def self.set args
		args.each do |arg|
			puts arg
		end
	end
	'''
end

class Fixnum
	def divisibleBy?(d)
		self % d == 0
	end
end
