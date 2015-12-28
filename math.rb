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

	def sqrt
		return Math.sqrt(@num)
	end

	def ^ pow
		return @num**pow
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

class Float
	def positive?
		return self > 0
	end
	def negative?
		return self < 0
	end
	def divisible_by?(d)
		self % d == 0
	end
	def prime?
		return false if self <= 1
		for d in 2..Math.sqrt(self) do
			return false if self.divisible_by?(d)
		end
		return true
	end
	def whole?
		return self % 1 == 0
	end
	def ^ pow
		return self ** pow
	end
	def sqrt
		return Math.sqrt(self)
	end
end

class Fixnum
	def positive?
		return self > 0
	end
	def negative?
		return self < 0
	end
	def divisible_by?(d)
		self % d == 0
	end
	def prime?
		return false if self <= 1
		for d in 2..Math.sqrt(self) do
			return false if self.divisible_by?(d)
		end
		return true
	end
	def whole?
		return true
	end
	def ^ pow
		return self ** pow
	end
	def sqrt
		return Math.sqrt(self)
	end
end
