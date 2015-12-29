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

			#elsif(args[0].action == "root") then
			#	variable = instance_variable_get "@#{name}"
			#	return variable.sqrt
			end
			return args[0]
		elsif args[0]
			#puts args[0].class
			return args[0]
		else
			begin
				return instance_variable_get "@#{name}"
			rescue
				"Error: Unrecoverable error"
			end
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
		if(val.class == Instruction) then
			return val
		else
			return Instruction.new(val)
		end
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

	def self.get(inst)
		inst
	end

	def self.occurrence(inst)
		inst
	end

	def self.first(inst)
		inst.action = "first"
		return inst
	end

	def self.last(inst)
		inst.action = "last"
		return inst
	end

	def self.find(inst)
		if inst.action == "first" then
			inst.action = "find first"
		elsif inst.action == "last" then
			inst.action = "find last"
		end
		return inst
	end

	def self.text(inst)
		if inst.class == Instruction then
			return inst
		else
			return Instruction.new(inst)
		end
	end

	def self.letter(val, val2=nil)
		inst = Instruction.new(val)
		if val2 then 
			inst.addValue(val2)
			inst.action = "substring"
		else
			inst.action = "letter"
		end
		return inst
	end

	def self.length(inst)
		#str = instance_variable_get "@#{inst.variable}"
		#p str
		return inst.values[0].length
	end

	def self.substring(inst)
		inst.action = "substring"
		return inst
	end

	def self.from(inst, val=nil)
		if inst.class == Instruction and inst.variable then
			if inst.action == "letter" then
				str = instance_variable_get "@#{inst.variable}"
				return str[inst.values[0]-1..inst.values[0]-1] # .. used for pre-1.9 versions
			elsif inst.action == "substring" then
				str = instance_variable_get "@#{inst.variable}"
				return str[inst.values[0]-1..inst.values[1]-1]
			elsif inst.action == "find first" then
				str = instance_variable_get "@#{inst.variable}"
				index = str.index(inst.values[0])
				return index ? index + 1 : nil
			elsif inst.action == "find last" then
				str = instance_variable_get "@#{inst.variable}"
				index = str.rindex(inst.values[0])
				return index ? index + 1 : nil 
			end
		elsif inst.class == Instruction then
			return inst
		elsif inst and val then
			#inst = Instruction.new(inst)
			inst.addValue(val)
			return inst
		else
			return
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
