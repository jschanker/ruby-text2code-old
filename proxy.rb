def set args
	Variables.send(:set, args)
end

def to args
	Variables.send(:to, args)
end

def method_missing(name, *args)
	if args.length > 0 then # Variables - set
		Variables.send(:method_missing, name, args[0])
	else # Variables - get
		Variables.send(:method_missing, name)
	end
end
