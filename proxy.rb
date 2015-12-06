def method_missing(m, arr=nil)
	if(arr.class == Array and arr[0] == "set") then
		#define_method "#{m}" do |param = arr[1]|
		#	return param
		#end
		#self.class."#{m}" = arr[1]
		#puts "#{m}"
		instance_variable_set "@#{m}", Mutablenum.new(arr[1])
		self.singleton_class.send(:attr_accessor, :"#{m}")
		#define_method "#{m}" do |n|
		#	instance_variable_set "@#{m}", Mutablenum.new(arr[1])
		#	self.singleton_class.send(:attr_accessor, :"#{m}")
		#end

		#@z = "abc"
		#print Object.z
		#self.singleton_class.send(:attr_accessor, "#{m}")
		#class_eval { attr_accessor "#{m}" }
        #instance_variable_set "@#{m}", arr[1]
		#puts "Here #{self.z}"
	end
end

def to arg
	if arg.class == Fixnum then
		return ["set", arg]
	end
end