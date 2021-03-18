# Working with Blocks

- What is the _type of action_ being performed?
- What is the _object_ that the action is being performed on?
- What is the _side-effect_ (if any) of that action?
- What is the _return value_ of that action?
- Is the _return value used_ by whatever instigated the action?

## Example 1

```ruby
[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `each` | Outer array `[[1, 2], [3, 4]]` | None | The calling object (outer array) | No, but shown on line 6 |
| 1-3 | block execution | Each sub-array `[1, 2]` `[3, 4]` | None | `nil` | No |
| 2 | method call `first` | Each sub-array `[1, 2]` `[3, 4]` | None | Integer at index 0 of each sub-array `1` `3` | Yes, passed to `puts` as argument |
| 2 | method call `puts` | Element at index 0 of each sub-array `1` `3` | Outputs string representation of the integer argument `1` `3` | `nil` | Yes, used to determine implicit return of the block |

**Description**

The `Array#each` method is being called on the two-dimensional array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and assigned to the local variable `arr`. The `Array#first` method is called on `arr` and returns the object at index 0 of the current array. On the first iteration this will be the integer `1`, and on the second iteration this will be the integer `3`. This integer is then passed to the `puts` method as an argument, which will output a string representation of that integer on each iteration of the block. The `puts` method returns `nil`, and since there is no more code within the block, the block itself will return `nil` on each iteration. `each`, however, ignores this return value, since it always returns the calling object; in this case, the nested array `[[1, 2], [3, 4]]`. 

## Example 2

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
end
# 1
# 3
# => [nil, nil]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `map` | Outer array `[[1, 2], [3, 4]]` | None | New array `[nil, nil]` | No, but shown on line 6 |
| 1-3 | block execution | Each sub-array `[1, 2]` `[3, 4]` | None | `nil` | Yes, used by `map` for transformation (to determine value of each element in returned array) |
| 2 | method call `first` | Each sub-array `[1, 2]` `[3, 4]` | None | Integer at index 0 of each sub-array `1` `3` | Yes, passed to `puts` as argument |
| 2 | method call `puts` | Element at index 0 of each sub-array `1` `3` | Outputs string representation of the integer argument `1` `3` | `nil` | Yes, used to determine implicit return of the block |

**Description**

The `Array#map` method is being called on the two-dimensional array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and assigned to the local variable `arr`. The `Array#first` method is called on `arr` and returns the object at index 0 of the current array. On the first iteration this will be the integer `1`, and on the second iteration this will be the integer `3`. This integer is then passed to the `puts` method as an argument, which will output a string representation of that integer on each iteration of the block. The `puts` method returns `nil`, and since there is no more code within the block, the block itself will return `nil` on each iteration. The method `map` takes this return value and applies in for transformation, assigning the return value of each iteration as the current element in a new array. Finally, when iteration is complete, this array is returned with the value of `[nil, nil]`. 

## Example 3

```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `map` | Outer array `[[1, 2], [3, 4]]` | None | New array `[1, 3]` | No |
| 1-4 | block execution | Each sub-array `[1, 2]` `[3, 4]` | None | Integer at index 0 for each sub-array `1` `3` | Yes, used by `map` for transformation (to determine value of each element in returned array) |
| 2 | method call `first` | Each sub-array `[1, 2]` `[3, 4]` | None | Integer at index 0 of each sub-array `1` `3` | Yes, passed to `puts` as argument |
| 2 | method call `puts` | Element at index 0 of each sub-array `1` `3` | Outputs string representation of the integer argument `1` `3` | `nil` | No |
| 3 | method call `first` | Each sub-array `[1, 2]` `[3, 4]` | None | Integer at index 0 of each sub-array `1` `3` | Yes, used to determine implicit return of the block |

**Description**

The `Array#map` method is being called on the two-dimensional array `[[1, 2], [3, 4]]`. Each inner array is passed to the block in turn and assigned to the local variable `arr`. The `Array#first` method is called on `arr` and returns the object at index 0 of the current array. On the first iteration this will be the integer `1`, and on the second iteration this will be the integer `3`. This integer is then passed to the `puts` method as an argument. `puts` outputs a string representation of that integer to the console, and returns `nil`. Then on line 3, the `first` method is called again, returning the element at index 0 for the current sub-array (the integers `1` and `3` respectively). Because this is the final line of code within the block, the block itself will return the integer `1` and `3` on each iteration respectively. This value is then used by `map` for transformation, assigning it as the current element in a new array for each iteration through the calling array. Finally, `map` returns the transformed new array `[1, 3]`. 

## Example 4

```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | local variable initialization | local variable `my_arr` | None | Assigned value `[[18, 7], [3, 12]]` | No |
| 1 | method call `each` | Nested array `[[18, 7], [3, 12]]` | None | Calling object: nested array `[[18, 7], [3, 12]]` | Yes, assigned to local variable `my_arr` |
| 1-7 | outer block execution | each sub-array `[18, 7]` `[3, 12]` | None | each sub-array `[18, 7]` `[3, 12]` | No |
| 2 | method call `each` | each sub-array `[18, 7]` `[3, 12]` | None | each sub-array `[18, 7]` `[3, 12]` | Yes, used as implied return value for the outer block |
| 2-6 | inner block execution | each integer element for the current sub-array | None | `nil` | No |
| 3 | comparison `>` | each integer element for the current sub-array | None | Boolean | Yes, used by `if` statement to determine control flow |
| 3-5 | `if` conditional | boolean expression `num > 5` | None | `nil` | Yes, used as implied return value for the inner block |
| 4 | method call `puts` | each integer element for the current sub-array, if that integer is greater than `5` | Outputs the current integer element as a string to the console | `nil` | Yes, used to determine return value of the conditional statement _if_ the condition is met |

**Output**

```ruby
# 18
# 7
# 12
# = > [[18, 7], [3, 12]]
```

**Description**

First, the local variable `my_arr` is initialized, and assigned the return value of the `each` method. Next, the method `each` is called on the two dimensional array `[[18, 7], [3, 12]]`. Each sub-array is passed to the outer block and assigned to the local variable `arr`. Then, the `each` method is again called on the current sub-array for that iteration. Each integer element of the current sub-array is passed to the inner block and assigned to the local variable `num`. In the inner block, comparison is used to determine if the current integer element for the sub-array of that iteration is greater than the integer `5`. 

For the first iteration of the inner block, `num` will reference the integer object `18`, so the statement will evaluate to `true`, and the code within the condition will execute. This is the method call `puts`, which is passed the current value of `num` (in this case, the integer `18`)
to output as a string to the console. `puts` returns `nil` which is used to determine the return value of the conditional, and furthermore, the inner block. `each` ignores this return value, however. In the next iteration of the inner block, `num` will reference the integer object `7`, so the condition will evaluate to `true` and `puts` will execute the same as before. The inner `each` will return the calling sub-array (`[18,7]` for the current iteration), and the outer block will move on to the next iteration, calling `each` on the sub-array `[3, 12]`. When `3` is passed to the conditional on the next iteration of the inner block, it will evaluate to `false` the `puts` will not run, and the statement will return `nil`. Finally, `12` is passed to the conditional which will evaluate to `true` output `12` as a string representation, and return `nil`. 

The return value of the inner `each` will be the calling sub-arrays for the respective iterations. This becomes the return value for the outer block due to Ruby's implied return. `each`, however, ignores the return value of the block that is passed to it and returns the calling array, `[[18, 7], [3, 12]]`. This is the value that is assigned to the variable `my_arr`. Because the return value of variable assignment is always the value that is assigned, it is also the final return value for the code.

## Example 5

```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `map` | nested array `[[1, 2], [3, 4]]` | None | new array `[[2, 4], [6, 8]]` | No |
| 1-5 | outer block execution | each sub-array `[1, 2]`//`[3, 4]` | None | new arrays `[2, 4]`//`[6, 8]` | Yes, used by top-level `map` for transformation |
| 2 | method call `map` | current sub-array for that iteration `[1, 2]`// `[3, 4]` | None | new arrays `[2, 4]`//`[6, 8]` | Yes, used to determine return value for the outer block |
| 2-4 | inner block execution | each integer element for the current sub-array | None | Integers `2`, `4`; `6`, `8`, on each iteration respectively | Yes, used by inner `map` for transformation |
| 3 | multiplication method call `*` with integer `2` as argument | each integer element for the current sub-array | None | Integers `2`, `4`; `6`, `8`, on each iteration respectively | Yes, used to determine the return value for the inner block |

**Output**
```ruby
# => [[2, 4], [6, 8]]
```

**Description**

First the `map` method is called on the two-dimensional array `[[1, 2], [3, 4]]`. Then each sub-array is passed into the outer block and assigned to the local variable `arr`. `map` is again called on the current sub-array for that iteration. Each integer element of the current iteration's sub-array is passed into the inner block and assigned to the local variable `num`. In the inner block, each integer element for the current iteration's sub-array invokes the multiplication method `*` and passes it the integer `2` as an argument. The `*` method returns `2`, `4` on each iteration of the first sub-array and `6`, `8` on each iteration of the second sub-array. This return value is used to determine the return value of the inner block, which is then used by the inner `map` for transformation. The return values for the inner `map` invocations are `[2, 4]` and `[6, 8]` respectively. These are used to determine the return value for the outer block on each iteration, which is then used by the top-level `map` for transformation of the calling array. Finally, the top-level map returns the new two-dimensional array `[[2, 4], [6, 8]]`. 


