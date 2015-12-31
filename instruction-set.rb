require './instruction.rb'

module InstructionPart
	VARIABLE = 1
	PREPOSITION = 2
	ACTION = 3
end

module InstructionCategory
	MATH = 1
end

module InstructionSet

	def add_instruction(vars, function, category)
	end

	#Instruction.create([VARIABLE, Msg.IS, Msg.EVEN])
	#IS_EVEN = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:even => InstructionPart::ACTION}]
	#puts IS_EVEN[0][:var1]
	#IS_ODD  = [{:var1 => InstructionPart::VARIABLE}, {:is => InstructionPart::PREPOSITION}, {:odd => InstructionPart::ACTION}]
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
end
