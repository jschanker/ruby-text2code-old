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
				return variable.divisibleBy?(args[0].values[0])
			end
			return args[0]
		else
			return instance_variable_get "@#{name}"
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
'''
	def createNewVariable(name, value)
		instance_variable_set "@{name}", value
		self.send(:attr_accessor, ":{name}")

		return instance_variable_get "@{name}"
	end
'''
end
