def set inst
	Variables.send(:set, inst)
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

def square inst
	Variables.send(:square, inst)
end

def root inst
	Variables.send(:root, inst)
end

def sqrt inst
	Variables.send(:sqrt, inst)
end

def of inst
	Variables.send(:of, inst)
end

def absolute inst
	Variables.send(:absolute, inst)
end

def remainder inst
	Variables.send(:remainder, inst)
end

def to inst
	Variables.send(:to, inst)
end

def by inst
	Variables.send(:by, inst)
end

def from(inst)
	Variables.send(:from, inst)
end

def text(inst)
	Variables.send(:text, inst)
end

def get(inst)
	Variables.send(:get, inst)
end

def letter(inst, val=nil)
	Variables.send(:letter, inst, val)
end

def find(inst)
	Variables.send(:find, inst)
end

def first(inst)
	Variables.send(:first, inst)
end

def last(inst)
	Variables.send(:last, inst)
end

def occurrence(inst)
	Variables.send(:occurrence, inst)
end

def substring(inst)
	Variables.send(:substring, inst)
end

def length(inst)
	Variables.send(:length, inst)
end

def is inst
	Variables.send(:is, inst)
end

def divisible inst
	Variables.send(:divisible, inst)
end

def even
	Variables.send(:even, Instruction.new)
end

def positive
	Variables.send(:positive, Instruction.new)
end

def negative
	Variables.send(:negative, Instruction.new)
end

def whole
	Variables.send(:whole, Instruction.new)
end

def odd
	Variables.send(:odd, Instruction.new)
end

def prime
	Variables.send(:prime, Instruction.new)
end

#def repeat
#end

def method_missing(name, *args)
	if args.length > 0 then # Variables - set
		Variables.send(:method_missing, name, args[0])
	else # Variables - get
		Variables.send(:method_missing, name)
	end
end
