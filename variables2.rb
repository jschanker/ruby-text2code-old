class Variables
	def self.set(value, variable)
		puts "VARIABLE SET NOW"
		# arg[0] = var name, arg[1] = "to", arg[2] = value
		instance_variable_set "@#{variable}", value
		self.send(:attr_accessor, "#{variable}")

		#puts value
		#puts Variables.get(variable)			
			
		return Variables.get(variable)
		#MutableNum.send(:set, args)
	end

	def self.get(variable)
		puts "GO HEREb"
		return instance_variable_get "@#{variable}"
	end

	def self.method_missing(*args)
		puts "STOP HERE"
	end
end

#puts Variables.set("foo", 5)
puts Variables.get("foo")
