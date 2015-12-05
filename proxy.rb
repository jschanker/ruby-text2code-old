def method_missing(m, arr=nil)
	if(arr.class == Array and arr[0] == "div") then
		puts m
		return "#{m}".to_i.is divisible by arr[1]
	end
	if(arr.class == Array and arr[0] == "char") then
		puts "Hwew"
		puts "#{m}".to_i.to_s
		puts "#{m}".to_s.letterAtPos arr[1]
		return "#{m}".to_s[arr[1]]
	end
end