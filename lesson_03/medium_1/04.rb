=begin 
Given are two implementations of a rolling buffer. 
  - Elements are added to the rolling buffer
  - If the buffer becomes full, the new elements added will displace the
    oldest elements in the buffer
Is there a difference between using << or + for modifying the buffer?
Is there another difference between the two implementations?
=end

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

p rolling_buffer1([1, 2, 3, 4], 4, 5)
p rolling_buffer2([1, 2, 3, 4], 4, 5)

=begin 
Yes, there is a difference between using << or +. The Array#+ method will
return a new array, while the Array#<< method will mutate the caller, and
return the original array (modified). Further, the Array#<< method can add
any object (regardless of data type) as the last element in the calling
array, while the Array#+ method requires the object to be added to be in the
form of another array. #+ will take those elements in the array to be added
and add them each as individual elements to the calling array (returning a 
new array), while #<< will take an array given and add it to the calling array
as a single element, a sub-array.

Because of the different methods used to append elements to the buffer, 
rolling_buffer1 will be mutating with respect to its arguments (mutating
buffer), but rolling_buffer2 will not.
=end