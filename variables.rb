#class MutableNum

#end

class Variable
	#set
	def self.method_missing(m, *args)
		if(args[0]) then
			if(args[0].class == Fixnum) then
				args[0] = Mutablenum.new(args[0])
			end
			instance_variable_set "@#{m}", args[0]
			print args[0]
		else
			return instance_variable_get "@#{m}"
		end
	end
end


def let exp
	# nothing to do here: allow ordinary assignment
	if exp.class != Fixnum then

	end
end