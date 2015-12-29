class String
	def get(inst)
		Variables.send(:get, inst)
		set __free_string__ to self
		Variables.send(:__free_string__, inst)
	end
	def find(inst)
		Variables.send(:find, inst)
		set __free_string__ to self
		Variables.send(:__free_string__, inst)
	end
end
