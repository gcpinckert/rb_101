# Predict how the values and object ids will change throughout the flow
# Here there is a method call instead of a block
# All outer variables are being passed into the method instead of into a block

def fun_with_ids
  a_outer = 42            # => 42
  b_outer = "forty two"   # => 'forty two'
  c_outer = [42]          # => [42]
  d_outer = c_outer[0]    # => 42

  a_outer_id = a_outer.object_id  # => some_number a
  b_outer_id = b_outer.object_id  # => some_number b
  c_outer_id = c_outer.object_id  # => some_number c
  d_outer_id = d_outer.object_id  # => some_number a (same value as a, therefore same object_id)

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  puts

  an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)
  # We pass all the variable values listed above into the second method (really this is a copy of each variable reference)
  # But the changes to these variables within an_illustrative_method will not be reflected in the code below
  # The variable names used here are not the same as the ones instantiated above
  # Any changes made within an_illustrative_method will not be reflected below,
  # because by re-assigning the variables within the method, we have severed the variables from their original
  # reference, which is what linked them to the values listed in the similarly named variables above

  # Each will print it's original object's value (as listed above), and both object ids before and after the method
  # call will be the same
  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the method call."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the method call."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the method call."
  puts

  # Each will print "ugh ohhhhh" because the variables instantiated in the an_illustrated_method are not available
  # within the scope of the fun_with_ids method
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
  puts
end


def an_illustrative_method(a_outer, b_outer, c_outer, d_outer, a_outer_id, b_outer_id, c_outer_id, d_outer_id)

  # The reference stored within each variable that points to the object is passed into the method
  # As a new variable (although they have the same name)
  # Object id both inside and outside of the method will be the same
  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."
  puts "b_outer id was #{b_outer_id} before the method and is: #{b_outer.object_id} inside the method."
  puts "c_outer id was #{c_outer_id} before the method and is: #{c_outer.object_id} inside the method."
  puts "d_outer id was #{d_outer_id} before the method and is: #{d_outer.object_id} inside the method."
  puts

  # Variables are re-assigned, breaking the link between the variable name and the original reference (object id) and object
  # Now variables will have a new object id that points to the newly created objects listed below
  a_outer = 22              # => 22
  b_outer = "thirty three"  # => 'thirty three
  c_outer = [44]            # => [44]
  d_outer = c_outer[0]      # => 44

  # Variable values will reflect re-assignment above, and each object id will be different before and after reassignment
  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
  puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
  puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
  puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
  puts

  # New variables instantiated inside the method will have the same reference as the outer variables
  # And will, therefore, point to the same object
  # However due to discreet scope of method, these variables will not be accessible outside the method
  a_inner = a_outer   # => 22
  b_inner = b_outer   # => 'thirty three'
  c_inner = c_outer   # => [44]
  d_inner = c_inner[0]# => 44

  a_inner_id = a_inner.object_id  # => same object id as a_outer (after reassignment)
  b_inner_id = b_inner.object_id  # => same object id as b_outer  (after reassignment)
  c_inner_id = c_inner.object_id  # => same object id as c_outer (after reassignment)
  d_inner_id = d_inner.object_id  # => same object id as d_outer (after reassignment)

  # Here, each object id inside the method when compared to the object id outside the method will be the same
  # Because the inner variables are pointing towards the same objects as the outer variables (after reassignment)
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the method (compared to #{b_outer.object_id} for outer)."
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the method (compared to #{c_outer.object_id} for outer)."
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the method (compared to #{d_outer.object_id} for outer)."
  puts
end