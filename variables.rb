class Variables
	def self.set(args)
		# arg[0] = var name, arg[1] = "to", arg[2] = value
		if(args[2].class == Fixnum) then
			instance_variable_set "@#{args[0]}", MutableNum.new(args[2])
			self.send(:attr_accessor, "#{args[0]}")			
			
			return instance_variable_get "@#{args[0]}"
			#MutableNum.send(:set, args)
		end
	end

	def self.method_missing(name, *args)
		# assume method name was variable
		if(args.length > 0) then
			if(args[0][0] == "to")
				[name].concat(args[0])
			end
		else
			return instance_variable_get "@#{name}"
		end
	end

	def self.to(args)
		#["to"] + [args]
		["to"] + [args]
	end
'''
	def createNewVariable(name, value)
		instance_variable_set "@{name}", value
		self.send(:attr_accessor, ":{name}")

		return instance_variable_get "@{name}"
	end
'''
end
