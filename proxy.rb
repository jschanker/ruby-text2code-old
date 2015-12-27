def set args
	Variables.send(:set, args)
end

def increase inst
	Variables.send(:increase, inst)
end

def decrease inst
	Variables.send(:decrease, inst)
end

def multiply inst
	Variables.send(:multiply, inst)
end

def divide inst
	Variables.send(:divide, inst)
end

def to args
	Variables.send(:to, args)
end

def by args
	Variables.send(:by, args)
end

def is args
	Variables.send(:is, args)
end

def divisible args
	Variables.send(:divisible, args)
end

def method_missing(name, *args)
	if args.length > 0 then # Variables - set
		Variables.send(:method_missing, name, args[0])
	else # Variables - get
		Variables.send(:method_missing, name)
	end
end
