# What will happen when the greeting variable is referenced in the last
# line of the given code?

if false
  greeting = "hello world"
end

greeting

# Nothing will be output to the screen, but no NameError will occur either.
# This is because when you initialize a local variable inside an if statement
# it will get assigned the value nil. Should the if statement execute, it
# will get assigned the value in the assignment statement within. If not, it
# will continue to reference the value nil. Here, the if statement is never
# run, but greeting references the value nil, so there will be no errors.