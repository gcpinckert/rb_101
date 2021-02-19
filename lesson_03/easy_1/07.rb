# Given the following code, make an un-nested array

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

p flintstones

flintstones.flatten!

p flintstones