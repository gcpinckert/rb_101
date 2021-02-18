# What do you expect the following code to print?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

=begin
=> 1
=> 2
=> 2
=> 3

Because the Array#uniq method does not mutate the caller, puts will be
passed the original value of numbers. In order to print the modified array
we would need to capture that value in a variable, or use the destructive
method #uniq!

Further, because puts automatically converts it's argument to a string
(using to_s), we get the output in the format shown.
= end