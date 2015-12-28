require './instruction.rb'

class Variables
	def self.set(inst)
		# arg[0] = var name, arg[1] = "to", arg[2] = value
		instance_variable_set "@#{inst.variable}", inst.values[0]
		self.send(:attr_accessor, "#{inst.variable}")			
			
		return instance_variable_get "@#{inst.variable}"
		#MutableNum.send(:set, args)
	end

	def self.method_missing(name, *args)
		# assume method name was variable
		if(args[0] and args[0].class == Instruction) then
			args[0].variable = name
			if(args[0].action == "divisible") then
				variable = instance_variable_get "@#{name}"
				return variable.divisible_by?(args[0].values[0])
			elsif(args[0].action == "even") then
				variable = instance_variable_get "@#{name}"
				return variable.even?
			elsif(args[0].action == "odd") then
				variable = instance_variable_get "@#{name}"
				return variable.odd?
			elsif(args[0].action == "positive") then
				variable = instance_variable_get "@#{name}"
				return variable.positive?
			elsif(args[0].action == "negative") then
				variable = instance_variable_get "@#{name}"
				return variable.negative?
			elsif(args[0].action == "prime") then
				variable = instance_variable_get "@#{name}"
				return variable.prime?
			elsif(args[0].action == "whole") then
				variable = instance_variable_get "@#{name}"
				return variable.whole?

			elsif(args[0].action == "root") then
				variable = instance_variable_get "@#{name}"
				return variable.sqrt
			end
			return args[0]
		else
			#begin
				return instance_variable_get "@#{name}"
			#rescue
			#	puts "ERROR"
			#end
		end
	end

	def self.to(val)
		Instruction.new(val)
	end

	def self.by(val)
		Instruction.new(val)
	end

	def self.is(inst)
		inst
	end

	def self.of(val)
		Instruction.new(val)
	end

	def self.increase(inst)
		variable = instance_variable_get "@#{inst.variable}"
		variable.send(:increase, inst.values[0])
	end
	def self.decrease(inst)
		variable = instance_variable_get "@#{inst.variable}"
		variable.send(:decrease, inst.values[0])
	end
	def self.multiply(inst)
		variable = instance_variable_get "@#{inst.variable}"
		variable.send(:multiply, inst.values[0])
	end
	def self.divide(inst)
		variable = instance_variable_get "@#{inst.variable}"
		variable.send(:divide, inst.values[0])
	end
	def self.divisible(inst)
		inst.action = "divisible"
		return inst
	end
	def self.even(inst)
		inst.action = "even"
		return inst
	end
	def self.odd(inst)
		inst.action = "odd"
		return inst
	end
	def self.prime(inst)
		inst.action = "prime"
		return inst
	end
	def self.positive(inst)
		inst.action = "positive"
		return inst
	end
	def self.negative(inst)
		inst.action = "negative"
		return inst
	end
	def self.whole(inst)
		inst.action = "whole"
		return inst
	end
	def self.root(inst)
		inst = Instruction.new(inst) unless inst.class == Instruction
		inst.action = "root"
		return inst
	end
	def self.sqrt(inst)
		inst = Instruction.new(inst) unless inst.class == Instruction
		inst.action = "root"
		return self.square(inst)
	end
	def self.absolute(inst)
		return inst.abs unless inst.class == Instruction
		return inst.values[0] if inst.values and inst.values.length > 0 end

	def self.square(inst)
		#inst.action = "square" unless inst.action
		#return inst
		if inst.action == "root" and inst.values.length > 0 then
			return inst.values[0].sqrt
		end
	end
'''
	def createNewVariable(name, value)
		instance_variable_set "@{name}", value
		self.send(:attr_accessor, ":{name}")

		return instance_variable_get "@{name}"
	end
'''
end
