# Given the two method definitions...

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

# What is the return value of the method call?
bar(foo)

# foo, argument to bar, returns yes so method call becomes:
# bar('yes')
# Evaluating the ternary expression in the bar method...
# 'yes' assigned to param does not equal 'no', so 'no' is returned
