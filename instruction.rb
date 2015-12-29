# Determines type of variable value from context of instruction 
# and how it should be handled when referenced in an instruction
class Instruction
	attr_accessor :action, :variable

	def initialize(val=nil)
		@values = []
		if val then
			self.addValue(val)
		end
	end

	def values
		#if @values.length == 1 then
		#	return @values[0]
		#else
			return @values
		#end
	end

	def values=(val)
		self.addValue(val)
	end

	def addValue(val)
		if val.class == Fixnum or val.class == Float then
			@values.push(MutableNum.new(val))
		else
			@values.push(val)
		end
	end

'''
	def initialize(value)
		if(value.class == Fixnum or value.class == Float) then
			@value = MutableNum.new(value)
		else
			@value = value
		end
	end

	def run
		if(@action) then

		else
			return instance_variable_get "@#{value}"
		end
	end 
'''
end
