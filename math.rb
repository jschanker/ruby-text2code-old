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
	def remainder d
		@num % d
	end

	def self.sqrt val
		return val.class == MutableNum ? val.sqrt : Math.sqrt(val)
	end

	def sqrt
		return Math.sqrt(@num)
	end

	def self.abs val
		return val.class == MutableNum ? val.abs : abs(val)
	end

	def abs
		return @num.abs
	end

	def ^ pow
		return @num**pow
	end

	def == n
		return @num == n
	end

	def to_s
		#return @num
		return @num.to_s # why is to_s needed to avoid #<MutableNum:...> display?
	end

	def divisible d
		return @num % d == 0
	end

	def is bool
		bool
	end

	def by d
		d
	end

	def times &block
		@num.times {yield}
	end

	def method_missing(name, *args)
		#puts name
		#puts 42.send(name, 10)
		#puts send(:name, args)
		return self.num.send(name, *args)
	end

	def set(x)
		@num = x
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
	def even?
		self.to_i.even? if self.whole?
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
	def to(inst)
		# TODO : Fill in later
	end
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

	def is(inst)
		if(inst.class == Instruction) then
			if(inst.action == "divisible") then
				self.divisible_by?(inst.values[0])
			end
		end
	end

end
