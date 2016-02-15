class Numeric
	def sqrt; Math.sqrt(self); end
	def abs; self.abs; end
	def positive?; self > 0; end
	def negative?; self < 0; end
	def whole?; self.round == self; end
	def divisible_by?(d); self.modulo(d) == 0; end
	def prime?
		return false if !self.whole? || self <= 1
		for d in 2..Math.sqrt(self) do
			return false if self.divisible_by?(d)
		end
		return true
	end
end

class String
	def char_at(index); self[index-1..index-1]; end
	def substring(startIndex,endIndex); self[startIndex-1...endIndex]; end
	def find(needle); self.index(needle)+1 end
	def rfind(needle); self.rindex(needle)+1 end
end

module Text2Code
	class Variable
		def initialize(val=nil)
			@value = val
		end
		def get(*args)
			@value
		end
		def set(val)
			@value = val
		end
		def increase(offset)
			@value += offset
		end
		def decrease(offset)
			@value -= offset
		end
		def multiply(offset)
			@value *= offset
		end
		def divide(offset)
			@value /= offset
		end
		def method_missing(method_name, *args)
			@value.send(method_name, *args)
		end
	end

	class InstructionComponents
		attr_reader :has_receiver, :arguments, :message
		#attr_reader :part_types

		def initialize(instComponents=nil)
			if(instComponents.class == InstructionComponents)
				@has_receiver = instComponents.has_receiver
				@message = instComponents.message
				@arguments = instComponents.arguments
				#@part_types = instComponents.part_types
			else
				@has_receiver = false
				@message = nil;
				@arguments = 0
				#@part_types = nil
			end
		end

		def add_type(part_type, part_val=nil)
			case part_type
			when :receiver
				has_receiver = @has_receiver
				@has_receiver = true
				instComponents = InstructionComponents.new(self)
				@has_receiver = has_receiver
			when :message
				message = @message
				@message = part_val
				instComponents = InstructionComponents.new(self)
				@message = message
			when :argument
				@arguments += 1
				instComponents = InstructionComponents.new(self)
				@arguments -= 1
			when :optional
				instComponents = InstructionComponents.new(self)
			end

			return instComponents
		end

		def is_complete?
			has_receiver && message != nil
		end

		def has_schema(inst)
			return inst.arguments.length == @arguments && 
				   (!!inst.receiver == @has_receiver || inst.variables.length > 0) && 
			       (inst.method_name == @message || inst.methods.include?(@message))
		end
	end

	class Instruction
		attr_accessor :receiver, :method_name, :arguments
		attr_accessor :methods, :variables

		def initialize(*args)
			args[0].class == Instruction ? args[0].copy : Instruction.create_from_args(self, :args, *args)
		end

		def self.instruction_types
			[:args, :receiver_last]
		end

		def self.create_all_instruction_types(*args)
			return Instruction.instruction_types.map {|type| Instruction.create_from_args(nil, type, *args)}
		end

		def copy
			inst = Instruction.new 
			inst.receiver = @receiver
			inst.method_name = @method_name
			inst.arguments = @arguments.map {|argument| argument} # shallow copy of array
			inst.methods = @methods
			inst.variables = @variables

			inst
		end

		def self.create_from_args(inst, type, *args)
			inst = inst || Instruction.new
			inst = args[0] if args.length > 0 && args[0].class == Instruction
			#filteredArgs = args.select {|arg| arg.class != Instruction}

			case type
				when :receiver_last
					last_arg = args.length > 0 ? args.pop : nil
					inst.receiver = last_arg.class == Instruction ? last_arg.receiver : last_arg
			end

			inst.arguments = inst.arguments ? args + inst.arguments : args unless (args.length > 0 && args[0].class == Instruction) # for both :args and :receiver_last
			#inst.arguments = inst.arguments ? filteredArgs + inst.arguments : filteredArgs
			inst.methods = inst.methods || []
			inst.variables = inst.variables || []

			inst
		end

		#def construct_from_parts
		#end
	end

	class InstructionSet
		def initialize
			@instruction_schemas = {:method_missing => [[InstructionComponents.new,:get]]} #name-value pairs
			@variable_set = {}
		end

		def add_instruction_schema(schema_parts, method_to_call)
			prev_inst_comps = InstructionComponents.new
			curr_inst_comps = []
			schema_parts.reverse.each_with_index do |part, index|
				if part.class == Symbol
					curr_inst_comps = prev_inst_comps.add_type(part)
				elsif part.class == Hash
					part.each do |method_name, instruction_type|
						method_name = (method_name != :variable_) ? method_name : :method_missing

						@instruction_schemas[method_name] = [] unless @instruction_schemas.has_key?(method_name)
						curr_inst_comps = prev_inst_comps.add_type(instruction_type, method_name)
						@instruction_schemas[method_name].push([prev_inst_comps, index == schema_parts.length-1 ? method_to_call : nil])

					end
				end
				prev_inst_comps = curr_inst_comps
			end

		end

		def create_methods
			@instruction_schemas.each do |method_name, inst_component_method_pairs_arr|
				self.class.send(:define_method, method_name) do |*args|
					method_to_call = nil
					is_variable = false

					if method_name == :method_missing then
						method_nameV = args.shift() # changing method_nameV to method_name makes it defined on subsequent calls?
						@variable_set[method_nameV] = @variable_set[method_nameV] || Variable.new
						is_variable = true
					end
					
					pair = nil
					instruction_to_run = Instruction.create_all_instruction_types(*args).detect do |instruction|
						instruction.methods.push(method_name) unless is_variable
						instruction.variables.push(method_nameV) if is_variable

						pair = inst_component_method_pairs_arr.detect { |component| component[0].has_schema(instruction)}#; p component}
						method_to_call = pair[1] if pair.class == Array

						if pair
							instruction.method_name = instruction.method_name || pair[0].message
							instruction.receiver = instruction.receiver || @variable_set[instruction.variables.shift()] if (pair && pair[0].has_receiver)
						end

						pair
					end

					if method_to_call && instruction_to_run
						if is_variable && instruction_to_run.receiver == nil
							instruction_to_run.receiver = @variable_set[instruction_to_run.variables.shift()]
						end
						return instruction_to_run.receiver.send(method_to_call, *instruction_to_run.arguments)
					end

					return instruction_to_run || Instruction.new(*args)
					
					nil
				end
			end

			puts set x to 5
			puts increase x by (x + 8)
			puts divide x by (x/2)

			puts @variable_set
			puts x is even
			puts x is odd
			puts x is positive
			puts x is whole
			#set x to 5.5
			puts x is whole
			set x to 49.5
			puts x is prime
			#puts (absolute of -4.5).whole?
			puts sqrt 4
			puts absolute 3
			puts set x to 49
			puts set d to 5
			puts x is divisible by -2*x
			puts remainder of x divided by (d divided by 5)
			#puts x divided by 5
			puts square root of 2.5
			#puts foo is even
			set s to "Molloly"
			puts length of s
			puts from text s get letter 2
			puts from text s get substring from 2,4
			puts from text s find last occurrence of "ol"
		end

		def getMatchingSchema(partial_inst)

		end
	end

	inst_set = InstructionSet.new

	inst_set.add_instruction_schema([{:set => :message}, {:variable_ => :receiver}, {:to => :optional}, :argument], :set)

	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:even => :message}], :even?)
	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:odd => :message}], :odd?)
	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:positive => :message}], :positive?)
	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:negative => :message}], :negative?)
	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:prime => :message}], :prime?)
	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:whole => :message}], :integer?)

	inst_set.add_instruction_schema([{:increase => :message}, {:variable_ => :receiver}, {:by => :optional}, :argument], :increase)
	inst_set.add_instruction_schema([{:decrease => :message}, {:variable_ => :receiver}, {:by => :optional}, :argument], :decrease)
	inst_set.add_instruction_schema([{:multiply => :message}, {:variable_ => :receiver}, {:by => :optional}, :argument], :multiply)
	inst_set.add_instruction_schema([{:divide => :message}, {:variable_ => :receiver}, {:by => :optional}, :argument], :divide)

	inst_set.add_instruction_schema([{:variable_ => :receiver}, {:is => :optional}, {:divisible => :message}, {:by => :optional}, :argument] , :divisible_by?)
	inst_set.add_instruction_schema([{:remainder => :message}, {:of => :optional}, {:variable_ => :receiver}, {:divided => :message}, {:by => :optional}, :argument] , :modulo)

	inst_set.add_instruction_schema([{:absolute => :message}, {:of => :optional}, :receiver], :abs)
	inst_set.add_instruction_schema([{:absolute => :message}, :receiver], :abs)
	inst_set.add_instruction_schema([{:sqrt => :message}, :receiver], :sqrt)
	inst_set.add_instruction_schema([{:square => :message}, {:root => :message}, {:of => :optional}, :receiver], :sqrt)


	inst_set.add_instruction_schema([{:length => :message}, {:of => :message}, :receiver], :length)
	inst_set.add_instruction_schema([{:from => :optional}, {:text => :message}, {:variable_ => :receiver}, {:get => :message}, {:letter => :message}, :argument], :char_at)
	inst_set.add_instruction_schema([{:from => :optional}, {:text => :message}, {:variable_ => :receiver}, {:get => :message}, 
		                             {:substring => :message}, {:from => :optional}, :argument, :argument], :substring)

	inst_set.add_instruction_schema([{:from => :optional}, {:text => :message}, {:variable_ => :receiver}, {:find => :message}, 
		                             {:first => :message}, {:occurrence => :optional}, {:of => :optional}, :argument], :find)
	inst_set.add_instruction_schema([{:from => :optional}, {:text => :message}, {:variable_ => :receiver}, {:find => :message}, 
		                             {:last => :message}, {:occurrence => :optional}, {:of => :optional}, :argument], :rfind)

	inst_set.create_methods
end

def method_missing(name, *args)
	Text2Code::InstructionSet.send(name, *args) # redirect to Text2Code Instruction
end
