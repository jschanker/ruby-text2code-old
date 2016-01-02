#require './instruction.rb'
require 'set'
require './math.rb'
require './variables2.rb'

module Text2Code

	class Instruction
		DEFAULT_VALUE = :EMPTY
		attr_accessor :receiver, :method_name, :class_receiver, :part_type
		attr_reader :values, :actions

		def initialize(*args)
			#p "Here"
			@values = []
			@actions = []

			if(args[0].class == Instruction) then
				@receiver = args[0].receiver unless !args[0].receiver
				args[0].values.each {|val| self.add_value(val)}
				args[0].actions.each{|action| self.add_action(action)}
				#p self
			else
				args.each {|val| self.add_value(val)}
				#p @values
			end
		end

		def add_value(val=DEFAULT_VALUE)
			if(val.class == Fixnum || val.class == Float) then
				@values.push(MutableNum.new(val))
			else
				@values.push(val)
			end

			#(val.class == Fixnum || val.class == Float) ? MutableNum.new(val) : val
		end

		def add_action(action)
			@actions.push(action)
		end

		def same_actions?(inst)
			@actions == inst.actions
		end

		def same_values?(inst)
			@values == inst.values
		end

		def has_same_form(inst)
			self.same_actions?(inst) && !!@receiver == !!inst.receiver && @values.length == inst.values.length
		end

		def ==(inst)
			self.same_values?(inst) && self.same_actions?(inst) && @receiver == inst.receiver
		end
	end

'''
	class PartialInstructionSchema
		def initialize
			@inst = Instruction.new
		end

		def ==(inst_schema)
			@inst.values.length == inst_schema.values.length &&
		end
	end
'''

	module InstructionPart
		VARIABLE = 1
		PREPOSITION = 2
		ACTION = 3
		VALUE = 4
		VERB = 5
		NOUN = 6
		TWO_VALUES = 7
	end

	module InstructionCategory
		VARIABLE = Variables
		MATH = MutableNum
		TEXT = 3
	end

	class InstructionSet

		def initialize
			#puts "Instruction Set initialized"
			#@instructions = []
			#@instruction_tree = {}
			#@keywords = {}
			@method_pairs = {}
		end

		def add_instruction(parts, method, category)
			instruction = Instruction.new
			(parts.length-1).downto(0).each do |index|
				parts[index].each do |method_name, instruction_type|
					@method_pairs[method_name] = [] unless @method_pairs.has_key?(method_name) || 
					                                       instruction_type == InstructionPart::VARIABLE ||
					                                       instruction_type == InstructionPart::VALUE
					
					instruction_cp = Instruction.new(instruction)
					instruction_cp.method_name = method if index == 0
					instruction_cp.class_receiver = category unless instruction.receiver
					instruction_cp.part_type = instruction_type
					@method_pairs[method_name].push(instruction_cp) unless instruction_type == InstructionPart::VARIABLE ||
					                                                       instruction_type == InstructionPart::VALUE

					case instruction_type 
					when InstructionPart::ACTION
						instruction.add_action(method_name)
					when InstructionPart::VALUE
						instruction.add_value
					when InstructionPart::TWO_VALUES
						instruction.add_value
						instruction.add_value
					when InstructionPart::VARIABLE
						instruction.receiver = Object
					end
				end
			end
		end

		def self.method_missing(name, *args)
			if(args[0] && args[0].class == Instruction) then
				instruction = args[0]
				instruction.receiver = name
				if instruction.receiver && instruction.method_name then
					return instruction.receiver.send(instruction.method_name, *instruction.values)
				else
					return instruction
				end
			elsif args[0]
				return args[0]
			else
				InstructionCategory::VARIABLE.get(name)
			end
		end

		def create_methods
			@method_pairs.each do |method_name, instructions|
				#alias_method
				p method_name
				p instructions
				puts "---"
				self.class.send(:define_method, method_name) do |*args|
					# To be processed correctly, args should either be a 1-element array containing an instruction
					# or a list of (non-Instruction) values
					#p *args
					ret_val = nil
					instruction = Instruction.new(*args)
					p instructions
					p method_name
					p instruction
					instructions.each do |inst|
						#p "INSTRUCTION:"
						#p instruction
						#p "INST: "
						#p inst
						#puts inst == instruction
						#if(args[0])
						#if inst == instruction then
						if inst.has_same_form(instruction) then
							puts "FOUND MATCH"
							p instruction
							print "RET VALUE: "
							p inst
							case inst.part_type
							when InstructionPart::ACTION
								instruction.add_action(method_name)
							end
							ret_val = instruction
							if inst.method_name then
								puts "EXECUTING METHOD"
								if instruction.receiver then
									ret_val = instruction.receiver.send(inst.method_name, *instruction.values)
								elsif inst.class_receiver then
									ret_val = inst.class_receiver.send(inst.method_name, *instruction.values)
								end
							end
						end
					end

					puts "**********"

					ret_val # loop above should be rewritten as while; should break as soon as it finds a matching instruction
				end
			end
		end

'''
		def add_instruction(parts, method, category)
			#@instructions.push({:parts => parts, :method => method, :category => category})
			#puts @instructions[@instructions.length-1]
			instruction = {:parts => parts, :method => method, :category => category}
			#possible_parameters = Set.new

			partSegments = (0...parts.length).map { |startIndex| parts[startIndex...parts.length]  }
			#(0...partSegments.length).each {|partSegment| print "#{partSegments[partSegment]}\n"}
			(parts.length-1).downto(0).each do |index|
				parts[index].each do |key, value|
					@instruction_tree[key] = Hash.new unless @instruction_tree.has_key?(key)
				end
			end

			parts.each do |partPair|
				partPair.each do |partName, partValue|
					if !@keywords[partName] then
						@keywords[partName] = []
					end
					@keywords[partName].push(instruction)
				end
			end


		end

		def create_methods
			@keywords = {}
			@instructions.each do |instruction|
				instruction[:parts].each do |partPair|
					partPair.each do |partName, partValue|
						if !@keywords[partName] then
							@keywords[partName] = []
						end
						@keywords[partName].push(instruction)
					end
				end
			end

			puts "----"

			@keywords.each do |partName, instructionsWithPartName|
				puts "#{partName}, #{instructionsWithPartName}"
			end

		end
'''
		#Instruction.create([VARIABLE, Msg.IS, Msg.EVEN])
		#IS_EVEN = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:even => InstructionPart::ACTION}]
		#puts IS_EVEN[0][:var1]
		#IS_ODD  = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:odd => InstructionPart::ACTION}]
	end

	inst_set = InstructionSet.new()

	inst_set.add_instruction([{:set => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:to => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :set, 
		                         InstructionCategory::VARIABLE)

	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:even => InstructionPart::ACTION}], :even?, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:odd => InstructionPart::ACTION}], :odd?, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:positive => InstructionPart::ACTION}], :positive?, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:negative => InstructionPart::ACTION}], :negative?, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:prime => InstructionPart::ACTION}], :prime?, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:whole => InstructionPart::ACTION}], :whole?, 
		                         InstructionCategory::MATH)

	inst_set.add_instruction([{:increase => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :increase, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:decrease => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :decrease, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:multiply => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :multiply, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:divide => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :divide, 
		                         InstructionCategory::MATH)

	inst_set.add_instruction([{:remainder => InstructionPart::ACTION}, 
		                         {:of => InstructionPart::PREPOSITION}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:divided => InstructionPart::ACTION},
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :remainder, 
		                         InstructionCategory::MATH)

	inst_set.add_instruction([{:var1 => InstructionPart::VARIABLE},
		                         {:divisible => InstructionPart::ACTION},
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :divisible_by?, 
		                         InstructionCategory::MATH)

	inst_set.add_instruction([{:absolute => InstructionPart::ACTION}, 
		                         {:val1 => InstructionPart::VALUE}], :abs, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:sqrt => InstructionPart::ACTION}, 
		                         {:val1 => InstructionPart::VALUE}], :sqrt, 
		                         InstructionCategory::MATH)
	inst_set.add_instruction([{:square => InstructionPart::ACTION},
								 {:root => InstructionPart::ACTION},  
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :sqrt, 
		                         InstructionCategory::MATH)


	inst_set.add_instruction([{:length => InstructionPart::ACTION}, 
		                         {:of => InstructionPart::PREPOSITION}, 
		                         {:val1 => InstructionPart::VALUE}], :length, 
		                         InstructionCategory::TEXT)
	inst_set.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:get => InstructionPart::VERB},
		                         {:letter => InstructionPart::ACTION},
		                         {:val1 => InstructionPart::VALUE}], :char_at, 
		                         InstructionCategory::TEXT)
	inst_set.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:get => InstructionPart::VERB},
		                         {:substring => InstructionPart::ACTION},
		                         {:from => InstructionPart::PREPOSITION},
		                         {:vals => InstructionPart::TWO_VALUES}], :substring, 
		                         InstructionCategory::TEXT)
	inst_set.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:find => InstructionPart::ACTION},
		                         {:first => InstructionPart::ACTION},
		                         {:occurrence => InstructionPart::NOUN},
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val => InstructionPart::VALUE}], :index, 
		                         InstructionCategory::TEXT)
	inst_set.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:find => InstructionPart::ACTION},
		                         {:last => InstructionPart::ACTION},
		                         {:occurrence => InstructionPart::NOUN},
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val => InstructionPart::VALUE}], :rindex, 
		                         InstructionCategory::TEXT)

	inst_set.add_instruction([{:prompt => InstructionPart::ACTION}, 
		                         {:to => InstructionPart::PREPOSITION}, 
		                         {:get => InstructionPart::VERB},
		                         {:text => InstructionPart::ACTION},
		                         {:with => InstructionPart::PREPOSITION},
		                         {:message => InstructionPart::ACTION},
		                         {:val => InstructionPart::VALUE}], :prompt, 
		                         InstructionCategory::TEXT)
	inst_set.add_instruction([{:prompt => InstructionPart::ACTION}, 
		                         {:to => InstructionPart::PREPOSITION}, 
		                         {:get => InstructionPart::VERB},
		                         {:number => InstructionPart::ACTION},
		                         {:with => InstructionPart::PREPOSITION},
		                         {:message => InstructionPart::ACTION},
		                         {:val => InstructionPart::VALUE}], :prompt, 
		                         InstructionCategory::TEXT)

	inst_set.create_methods()
	puts "Foo"
	#inst_set.to 1, 2, "abc"
	#my_inst = Instruction.new(5, 8)
	#my_inst.add_action("abc")
	#my_inst.receiver = "Foo"
	#inst_set.to my_inst
	#inst_set.sqrt :EMPTY
	puts inst_set.sqrt(6.25)
	puts inst_set.square(inst_set.root(inst_set.of(5)))
	puts "HERE"
	puts inst_set.square(inst_set.root(inst_set.of(MutableNum.new(0.0625))))
end
