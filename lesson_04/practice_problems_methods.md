# Practice Problems: Methods and More Methods

## Problem 1:
What is the return value of the `select` method below? Why?
```ruby
[1, 2, 3].select do |num|
  num > 5
  'hi'
end
```

The code above will return a _new_ array, `[1, 2, 3]`. All elements from the original calling array will be selected because the last line in the block `'hi'` has a truthy value. Therefore, the block always has a truthy return value, and all elements will be selected. With the current code, it is impossible to have new array returned that has less than the number of elements in the original calling array. 

## Problem 2:
How does `count` treat the block's return value? How can we find out?
```ruby
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end
```

`count` iterates through each element in the calling array, and passes the current element to the block. If the block returns a truthy value, it will increment the count, finally returning the total count for the number of elements for which the block returns a truthy value. Here, the code will return `2`. 

Information on the `count` method can be found in the [Array docs](https://ruby-doc.org/core-3.0.0/Array.html#method-i-count)

## Problem 3:
What is the return value of `reject` in the following code? Why?
```ruby
[1, 2, 3].reject do |num|
  puts num
end
```

The code above will return `[1, 2, 3]`. The Array method `reject` returns a new array whose elements are all those from the calling array that return `false` or `nil` when passed to the block. Because the last line of the block is `puts num`, the block will always return `nil` (the return value of `puts`). Therefore, all elements in the calling array will always be selected by `reject`. 

[Docs here](https://ruby-doc.org/core-3.0.0/Array.html#method-i-reject)

## Problem 4:
What is the return value of `each_with_object` in the following code? Why?
```ruby
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end
```

The code will return the following hash:
```ruby
{ 'a' => 'ant', 'b' => 'bear', 'c' => 'cat' }
```
This is because the method `each_with_object` iterates through the calling array, passing each element along with the object passed as an argument (here, an empty hash), to the block. In the block, the first letter of each element in the array (`value[0]`) is assigned as a new key in the hash object, with the full string value of the current array element assigned as the corresponding hash value. Finally, the method `each_with_object` returns the updated value of the object passed as argument, here the hash to which we have added the key-value pairs as outlined above. 

## Problem 5:
What does `shift` do in the following code? How can we find out?
```ruby
hash = { a: 'ant', b: 'bear' }
hash.shift
```

Information on the hash method `shift` can be found [here](hash = { a: 'ant', b: 'bear' }
hash.shift).

`shift` removes the first hash entry, and returns a 2-element array containing both the key and the value from the removed hash entry. Therefore, here, `shift` will destructively remove `:a => 'ant'` from the hash and return `[:a, 'ant']`. Further, `hash` will be modified permanently and now point to the value `{ :b => 'bear' }`.

## Problem 6:
What is the return value of the following statement? Why?
```ruby
['ant', 'bear', 'caterpillar'].pop.size
```

The following statement will return the integer value `11`. This is because `pop` is an array method that destructively modifies the calling array by removing the last element, and `pop` returns the value of the removed element. Therefore, when we chain the method `size` onto `pop`, the calling object of `size` is the string `'caterpillar'`. The string method `size` returns the number of characters in the calling string as an integer value, so we see that reflected by the return value of the statement above.

## Problem 7: 
What is the block's return value in the following code? How is it determined? Also, what is the return value of `any?` in this code and what does it output?
```ruby
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end
```

In the first iteration through the block, the block will return `true`, because the element passed to it (as the variable `num`) is the integer value `1`, and `1.odd?` will evaluate to `true`. 

The return value of the Enumerable method `any?` will be `true` in this case. The method returns `true` if the block returns a truthy value on any iteration of the collection, which in this case has happened on the first iteration.

At this point, the method will 'short circuit', and stop iterating through the calling array, since there is no need to continue evaluating. Therefore, `puts num` is only run once for the first array element.

## Problem 8:
How does `take` work? Is it destructive? How can we find out?
```ruby
arr = [1, 2, 3, 4, 5]
arr.take(2)
```

Information on the Array `take` method can be found [here](https://ruby-doc.org/core-3.0.0/Array.html#method-i-take).

`take` returns a new array containing the number of elements in the original array that is passed to it as an argument. `take` does _not_ act destructively, preserving the value of the original calling array. 

The return value for the code above will be `[1, 2]`. The variable `arr` will still point to the same collection of integers before and after the method call.

## Problem 9:
What is the return value of `map` in the following code? Why?
```ruby
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end
```

The return value of `map` above will be `[nil, 'bear']`. This is because map returns a new array in which each element is the return value of the block. `map` always returns a new array, even when being called on a hash. Further, because the first value passed to the block, `'ant'`, is not larger than 3 characters, the if statement will not run, giving us a return value of `nil`. This `nil` value is assigned to be the first element in the new array. Next, the value `'bear'` is passed into the block, and because it's size is greater than 3, the conditional evaluates to true, and the code within is run. In the conditional, the statement is just the `value` variable, which points to `'bear'`, so this value gets assigned to be the next element in the array. Finally, when iteration is complete, `[nil, 'bear']` is returned.

## Problem 10:
What is the return value of the following code? Why?
```ruby
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end
```

The return value of `map` above will be `[1, nil, nil]`. This is because `map` returns a new array in which each element is the return value of the block. Here, on the first iteration the value `1` is passed into the block using the placeholder variable `num`. When the if statement is evaluated, it evaluates to false so the code beneath the `else` is run. This simply returns the value of `1`, to which the variable `num` points, and this value gets assigned to be the first element in the new array. Next, `2` gets passed to the block as placeholder variable `num`. In this case, when the if statement is evaluated, it evaluates to true, so the code within the `if` is run. This is a `puts` statement, which always returns `nil`. Therefore, `nil` is the value that gets assigned to be the next element in the new array. The same thing happens again when the value `3` is passed to the block. Finally, when iteration is complete, the new array `[1, nil, nil]` is returned. 
