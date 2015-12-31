require './instruction.rb'

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
	VARIABLE = 1
	MATH = 2
	TEXT = 3
end

module InstructionSet

	def add_instruction(vars, function, category)
	end

	#Instruction.create([VARIABLE, Msg.IS, Msg.EVEN])
	#IS_EVEN = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:even => InstructionPart::ACTION}]
	#puts IS_EVEN[0][:var1]
	#IS_ODD  = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:odd => InstructionPart::ACTION}]
	Instruction.add_instruction([{:set => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:to => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :set, 
		                         InstructionCategory::VARIABLE)

	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:even => InstructionPart::ACTION}], :even?, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:odd => InstructionPart::ACTION}], :odd?, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:positive => InstructionPart::ACTION}], :positive?, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:negative => InstructionPart::ACTION}], :negative?, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:prime => InstructionPart::ACTION}], :prime?, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE}, 
		                         {:is => InstructionPart::PREPOSITION}, 
		                         {:whole => InstructionPart::ACTION}], :whole?, 
		                         InstructionCategory::MATH)

	Instruction.add_instruction([{:increase => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :increase, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:decrease => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :decrease, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:multiply => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :multiply, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:divide => InstructionPart::ACTION}, 
		                         {:var1 => InstructionPart::VARIABLE}, 
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :divide, 
		                         InstructionCategory::MATH)

	Instruction.add_instruction([{:remainder => InstructionPart::ACTION}, 
		                         {:of => InstructionPart::PREPOSITION}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:divided => InstructionPart::ACTION},
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :divided, 
		                         InstructionCategory::MATH)

	Instruction.add_instruction([{:remainder => InstructionPart::ACTION}, 
		                         {:of => InstructionPart::PREPOSITION}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:divided => InstructionPart::ACTION},
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :remainder, 
		                         InstructionCategory::MATH)

	Instruction.add_instruction([{:var1 => InstructionPart::VARIABLE},
		                         {:divisible => InstructionPart::ACTION},
		                         {:by => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :divisible_by?, 
		                         InstructionCategory::MATH)

	Instruction.add_instruction([{:absolute => InstructionPart::ACTION}, 
		                         {:val1 => InstructionPart::VALUE}], :abs, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:sqrt => InstructionPart::ACTION}, 
		                         {:val1 => InstructionPart::VALUE}], :abs, 
		                         InstructionCategory::MATH)
	Instruction.add_instruction([{:square => InstructionPart::ACTION},
								 {:root => InstructionPart::ACTION},  
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val1 => InstructionPart::VALUE}], :sqrt, 
		                         InstructionCategory::MATH)


	Instruction.add_instruction([{:length => InstructionPart::ACTION}, 
		                         {:of => InstructionPart::PREPOSITION}, 
		                         {:val1 => InstructionPart::VALUE}], :length, 
		                         InstructionCategory::TEXT)
	Instruction.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:get => InstructionPart::VERB},
		                         {:letter => InstructionPart::ACTION},
		                         {:val1 => InstructionPart::VALUE}], :char_at, 
		                         InstructionCategory::TEXT)
	Instruction.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:get => InstructionPart::VERB},
		                         {:substring => InstructionPart::ACTION},
		                         {:from => InstructionPart::PREPOSITION},
		                         {:vals => InstructionPart::TWO_VALUES}], :substring, 
		                         InstructionCategory::TEXT)
	Instruction.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:find => InstructionPart::ACTION},
		                         {:first => InstructionPart::ACTION},
		                         {:occurrence => InstructionPart::NOUN},
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val => InstructionPart::VALUE}], :index, 
		                         InstructionCategory::TEXT)
	Instruction.add_instruction([{:from => InstructionPart::PREPOSITION}, 
		                         {:text => InstructionPart::NOUN}, 
		                         {:var1 => InstructionPart::VARIABLE},
		                         {:find => InstructionPart::ACTION},
		                         {:last => InstructionPart::ACTION},
		                         {:occurrence => InstructionPart::NOUN},
		                         {:of => InstructionPart::PREPOSITION},
		                         {:val => InstructionPart::VALUE}], :rindex, 
		                         InstructionCategory::TEXT)

	Instruction.add_instruction([{:prompt => InstructionPart::ACTION}, 
		                         {:to => InstructionPart::PREPOSITION}, 
		                         {:get => InstructionPart::VERB},
		                         {:text => InstructionPart::ACTION},
		                         {:with => InstructionPart::PREPOSITION},
		                         {:message => InstructionPart::ACTION},
		                         {:val => InstructionPart::VALUE}], :prompt, 
		                         InstructionCategory::TEXT)
	Instruction.add_instruction([{:prompt => InstructionPart::ACTION}, 
		                         {:to => InstructionPart::PREPOSITION}, 
		                         {:get => InstructionPart::VERB},
		                         {:number => InstructionPart::ACTION},
		                         {:with => InstructionPart::PREPOSITION},
		                         {:message => InstructionPart::ACTION},
		                         {:val => InstructionPart::VALUE}], :prompt, 
		                         InstructionCategory::TEXT)
end
