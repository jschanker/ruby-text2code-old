def method_missing(m, arr=nil)
	if(arr.class == Array and arr[0] == "set") then
		define_method "#{m}" do |param = arr[1]|
			return param
		end
	end
end

def to arg
	if arg.class == Fixnum then
		return ["set", arg]
	end
end