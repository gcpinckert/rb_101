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

## Example 6

```ruby
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `select` | array of hashes `[{ a: 'ant', b: 'elephant' }, { c: 'cat' }]` | None | new array `[{ :c => "cat"}]` | No |
| 1-5 | outer block execution | each inner hash of calling array | None | Boolean | Yes, used by `select` to perform selection |
| 2 | method call `all?` | inner hash of the calling array for the current iteration | None | Boolean | Yes, used to determine return value of outer block |
| 2-4 | inner block execution | each key-value pair in the calling hash for the current iteration | None | Boolean | Yes, used to determine return value of `all?` |
| 3 | `String#[]` method call | string object referenced by the value for the current iteration's key-value pair | None | The character in the string at index 0 | Yes, used in comparison `==` |
| 3 | `to_s` method call | symbol object referenced by the key for the current iteration's key-value pair | None | String representation of the symbol object | Yes, used in comparison `==` |
| 3 | comparison `==` | The character at index 0 in the string object referenced by `value` and the character string representation of the object referenced by `key` | None | Boolean | Yes, used to determine the return value of the inner block. 

**Description**

First, the method `select` is called on the array of hashes `[{ a: 'ant', b: 'elephant' }, { c: 'cat' }]`. Each inner hash of the calling array is passed to the outer block and assigned to the local variable `hash`. Then, the `Enumerable#all?` method is called on the inner hashes for each iteration of the outer block. Each key-value pair in the calling hash for the current iteration is passed to the inner block and assigned to the local variables `key` and `value` respectively. Then, the `String#[]` method is called on the string object referenced by `value`, returning the character at index 0 in that string object. Next, `to_s` is called on the symbol object referenced by `key`, returning a string representation of that object. Both of these return values are compared for equality using `==`, returning a Boolean. Because this is the last line of code in the inner block, this Boolean becomes the return value of the inner block. The method `all?` returns a new Boolean based on whether the inner block _ever_ returns a `false` or `nil`. If not, `all?` will return `true`. The return value of `all?` will be the return value of the outer block due to Ruby's implied return. Then, `select` uses the return value of the outer block to perform selection. That is, it adds only those elements to the new array to return for whom the return value of the block is a truthy value. In this case, it will be the second hash to pass through the outer block, `{ :c => "cat"}`. The first hash contains a key-value pair which, when passed to the inner block will return a value of `false`. Therefore, `all?` will return `false` for that hash when invoked, and the hash will not be added to the new array. Finally, select returns a new array of one element, a hash, `[{ :c => "cat"}]`.

**Further Exploration**
If the code used the method `any?` in place of `all?` the return value of `select` would be the array `[{ a: 'ant', b: 'elephant' }, { c: 'cat' }]`. This is because `any?` in this case returns a value of `true` if the inner block returns a value of `true` at any point during iteration. In this case, both hashes in the calling array will return `true` when passed to the outer block, and so `select` will add both to the new array being returned.

## Example 7

When sorting nested arrays there are _two_ sets of comparisons happening. 
  1. Inner arrays are compared with each other
  2. Each element within the inner arrays are compared with each other

The following example demonstrates a nested array of numeric strings sorted according to the numeric value of the strings they contain (as opposed to ASCII order).

```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
# => [["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | variable assignment | n/a | None | nested array of numerical strings | No |
| 2 | method call `sort_by` | nested array of numerical strings | None | nested array of numerical strings, where each sub-string is sorted according to numeric value `[["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]` | No |
| 2-6 | outer block execution | each sub-array | None | each sub-array with integer representations of it's numerical strings | Yes, to perform the element-wise comparison for sorting in `sort_by` |
| 3 | method call `map` | The sub-array for the current iteration of the outer block | None | a new array containing integer representations of the current sub-array's elements | Yes, to determine the return value of the outer block |
| 3-5 | inner block execution | Each string element in the current iteration's sub-array | None | An integer representation of the each string element | Yes, used by `map` for transformation |
| 4 | method call `to_i` | Each string element in the current iteration's sub-array | None | An integer representation of each string element | Yes, used to determine the return value of the inner block |

**Description**

First, we initialize a two-dimensional array, in which each sub-array is an array of numerical strings, and assign it to the local variable `arr`. Then the method `sort_by` is called on the top-level array. Each sub-array is passed to the outer block and assigned to the local variable `sub_arr`. Next, the `map` method is called on the sub-array for the current iteration. Each element of the current sub-array, a numerical string, is passed to the inner block and assigned to the local variable `num`. Within the inner block, the `to_i` method is invoked on the current numerical string element, returning an integer representation of that string. This integer value is then returned by the inner block, and used by `map` to perform transformation. Namely, it is assigned as the current iteration's element in a new array. When the inner block finishes iterating, it returns a new array consisting of integer representations of all the elements in the outer block's current iteration's sub-array. This value is used to perform element-wise comparison in sorting by `sort_by`. Finally, `sort_by` returns a new two-dimensional array, in which all the sub-arrays are sorted according to numeric value: `[["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]`. 

## Example 8

When selecting nested elements in a multi-dimensional array consisting of different data types:
  1. Access the sub-arrays _before_ calling `select` method
  2. Use a conditional to determine the data type within the block.

```ruby
[[8, 13, 27], ['apple', 'banana', 'cantaloupe']].map do |arr|
  arr.select do |item|
    if item.to_s.to_i == item    # if it's an integer
      item > 13
    else
      item.size < 6
    end
  end
end
# => [[27], ["apple"]]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `map` | nested array `[[8, 13, 27], ['apple', 'banana', 'cantaloupe']]` | None | new nested array `[[27], ["apple"]]` | No |
| 1-9 | outer block execution | each sub-array in the calling array | None | new array after selection is performed based on block criteria | Yes, used by `map` for transformation |
| 2 | method call `select` | each element in the current iteration's sub-array | None | new array after selection is performed based on block criteria | Yes, used to determine return value of outer block |
| 2-8 | inner block execution | each element in the current iteration's sub-array | None | Boolean | Yes, used by `select` for selection |
| 3 | method call `to_s` | each element in current iteration's sub-array | None | string representation of the current iteration's element | Yes, calls method `to_i` |
| 3 | method call `to_i` | string representation of the current iteration's element | None | integer representation of the current iteration's element | Yes, used in comparison `==` |
| 3 | comparison `==` | integer representation of current iteration's element and the current iteration's element | None | Boolean | Yes, used by the `if..else` statement to determine control flow |
| 3-7 | `if..else` statement | Boolean | None | Boolean | Yes, used to determine return value of the inner block | 
| 4 | comparison `>` | current iteration's element | None | Boolean | Yes, used to determine the return value of the `if..else` statement |
| 6 | method call `size` | current iteration's element | None | integer representing the count of characters in the calling string | Yes, used in comparison `<` |
| 6 | comparison `<` | integer representing the count of characters in the current iteration's element | None | Boolean | Yes, used to determine the return value of the `if..else` statement |

**Description**

First, the `map` method is called on the two-dimensional array `[[8, 13, 27], ['apple', 'banana', 'cantaloupe']]`. Each sub-array is passed into the outer block and assigned to the local variable `arr`. The `select` method is then called on the current sub-array for each iteration of the outer block. Each element of the current sub-array is passed into the inner block and assigned to the local variable `item`. The method `to_s` is called on the current iteration's element, returning a string representation of that element. This value then calls the `to_i` method which returns an integer of that element. This value is compared, using `==`, to the current iteration's element, which returns a Boolean value that is passed to the `if` statement on line 3.

If the comparison expression returns `true`, the code in line 4 is executed. This uses comparison on the current iteration's element to see if the value referenced by `item` is greater than the integer `13`, and returns a Boolean, which becomes the return value of the `if...else` statement. If the comparison in line 3 returns `false` then the code in line 6 is run. Here, the method `size` is called on the current iteration's element, which returns an integer representing the count of characters in the calling string. Then, this value is used by comparison `< ` to determine if the integer returned is less than the integer `6`. The comparison expression returns a Boolean, which is used to determine the return value of the `if...else` statement.

Because there is no code following the `if...else` statement in the inner block, the Boolean returned by either line 4 or line 6 will be the return value for the inner block on each iteration. This Boolean will be used by the `select` method to perform selection on each element in the outer block's current iteration's sub-array. Next, `select` will return a new array for which each element returned `true` when passed into the inner block. In this case, `[27]` on the first iteration of the outer block and `["apple"]` on the second. Because there is no code following the inner block passed to `select` in the outer block, the return value of select is the return value of the outer block. 

Finally, the return value block on each iteration is used by `map` for transformation. After `map` completes iteration, it returns the new two-dimensional array `[[27], ["apple"]]`. 

## Example 9

A three-level nested array

```ruby
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | method call `map` | three-level array | None | new three-level array | No |
| 1-7 | top-level block execution | each 2nd level sub-array | None | each 2nd-level sub-array | Yes, used by `map` in transformation |
| 2 | method call `each` | each 2nd level sub-array | None | calling 2nd level sub-array | Yes, used to determine return value of top-level block |
| 2-6 | second-level block execution | each 3rd level sub-array | None | two-dimensional array, where each element is a sub-array containing the current 3rd level sub-array and an empty array | No |
| 3 | method call `partition` | each 3rd level sub-array | None | two-dimensional array, where each element is a sub-array containing the current 3rd level sub-array and an empty array | Yes, used to determine the return value of the second level block |
| 3-5 | third level block execution | each element of the current 3rd level sub-array | None | Boolean | Yes, used by `partition` for selection |
| 4 | method call `size` | integer element of each 3rd level sub array _or_ string element of each 3rd level sub-array depending on top-level block iteration | None | Integer | Yes, used by comparison `>` |
| 4 | comparison `>` | Integer returned by `size` | None | Boolean | Yes, used to determine return value of 3rd level block |

**Description**

First, the method `map` is called on the three-level array `[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]]`. Then, each 2nd level sub-array is passed into the top-level block, where it is assigned to the local variable `element1`. In the top-level block, the method `each` is called on each 2nd level sub-array, and each 3rd level sub-array is passed into the 2nd level block and assigned to the local variable `element2`. In the 2nd level block, the method `partition` is called on the 3rd level sub-array, and each element within the 3rd level sub-array is passed into the 3rd level block and assigned to the local variable `element3`. Within the 3rd level block, the method `size` is called on the current element, and the return value, an integer, is compared with the integer `0`. This comparison returns a Boolean, which is also the return value of the 3rd level block. The return value of the 3rd level block is used by the method `partition` to perform selection, which returns a two-dimensional array for each iteration of the 2nd level block. However, because `each` returns the calling array instead of using the return value of the 2nd level block, this value is disregarded. The `map` method, in this case, will return a new array that matches the value of the calling three-level array, because `each` will return a copy of the calling 2nd level sub-array on each iteration of the top-level block. The final return value will therefore be `[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]]`. 

## Example 10

The following example demonstrates a three-level array in which each number element is incremented by 1 without changing the data structure.

```ruby
[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1    # it's an integer
      el + 1
    else                    # it's an array
      el.map do |n|
        n + 1
      end
    end
  end
end
```

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | ------------------ |
| 1 | top level method call `map` | three-level nested array `[[[1, 2], [3, 4]], [5, 6]]` | None | new three-level nested array `[[[2, 3], [4, 5]], [6, 7]]` | No |
| 1-11 | top level block execution | each 2nd level sub-array | None | new second level sub-array with each integer element incremented by 1 and each integer element of any 3rd level sub arrays also incremented by 1 | Yes, used by top level `map` for transformation |
| 2 | 2nd level method call `map` | current 2nd level sub-array for that iteration | None | new second level sub-array with each integer element incremented by 1 and each integer element of any 3rd level sub arrays also incremented by 1 | Yes, used to determine return value of top level block |
| 2-10 | 2nd level block execution | each element in the current 2nd level sub-array | None | Either integer element of 2nd level sub-array plus one, _or_ a 3rd level sub-array with each element incremented by 1 | Yes, used by 2nd level `map` for transformation |
| 3 | method call `to_s` | each element in the current 2nd level sub-array | None | string representation of that element | Yes, calls chained `size` method |
| 3 | method call `size` | string representation of the current element in the current 2nd level sub-array | None | integer representing count of characters in the calling string | Yes, used in comparison `==` |
| 3 | comparison `==` | integer representing count of characters in string representation of current element | None | Boolean | Yes, used by `if...else` statement to determine control flow |
| 3-9 | `if...else` conditional statement | Boolean | None | Either integer element of 2nd level sub-array plus one, _or_ 3rd level sub-array with all elements incremented by 1 | Yes, used to determine return value of the 2nd level block |
| 4 | `+` operation with `1` passed as argument | integer element of 2nd level sub-array | None | integer element of 2nd level sub-array incremented by 1 | Yes, used to determine return value of `if...else` statement |
| 6 | 3rd level method call `map` | 3rd level sub-array | None | 3rd level sub-array with integer elements incremented by 1 | Yes, used to determine the return value of the `if...else` statement |
| 6-8 | 3rd level block execution | each element within 3rd level sub-array | None | Each element within the 3rd level sub-array incremented by 1 | Yes, used by 3rd level `map` for transformation |
| 7 | `+` operation with `1` passed as argument | current integer element of 3rd level sub-array | None | current integer element incremented by 1 | Yes, used to determine the return value of the 3rd level block |

**Description**

First, the `map` method is called on the three-level array `[[[1, 2], [3, 4]], [5, 6]]`. Then each 2nd level sub array is passed into the top level block and assigned to the local variable `arr` (`[[1, 2], [3, 4]]` and `[5, 6]` respectively on each iteration). Within the top level block, the 2nd level `map` is called on the 2nd level sub-array. Each element within the current 2nd level sub-array is passed to the 2nd level block and assigned to the local variable `el`. The method `to_s` is called on the current element, returning a string representation of that element. Then the chained method `size` is called on that string object, returning an integer value representing the count of characters in the calling string. That integer is compared using `==` to the integer `1`, returning a Boolean value. That Boolean is then passed to the `if...else` conditional statement. 

If the Boolean is `true` the code on line 4 is run; the `+` method is called on the integer element of the 2nd level sub-array and the integer `1` is passed as an argument. Thus, the return value is the integer element of the 2nd level sub-array incremented by `1`. Because there is no more code following the `if`, this value is the return value for the whole `if...else` conditional (here the integers `6` and `7`). 

If the Boolean is `false` the code on line 6 is run; the `map` method is called on the 3rd level sub-array. Each element in the 3rd level sub-array is passed into the 3rd level block and assigned to the local variable `n`. On each iteration of the 3rd level block, the current element calls the method `+` and the integer `1` is passed as an argument, returning the integer value of the current element incremented by `1`. This value is used by the 3rd level `map` in transformation, which ultimately returns a new 3rd level sub-array with all elements incremented by `1` (`[2, 3]` and `[4, 5]` respectively). These arrays will also be returned by the `if...else` statement on the appropriate iteration of the 2nd level block.

Next, the return values of the 2nd level block on each iteration will be used by the 2nd level `map` in transformation. In this case, `[2, 3]`, `[4, 5]`, `6`, `7` respectively. The 2nd level map will return new transformed 2nd level sub-arrays, namely `[[2, 3], [4, 5]]` and `[6, 7]` on each iteration. These return values will also be returned by the top level block, and are used by the top level `map` for transformation. Finally, the top level `map` method returns the newly transformed 3 level nested array `[[[2, 3], [4, 5]], [6, 7]]`


