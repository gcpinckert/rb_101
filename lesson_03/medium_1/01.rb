# Create a program that outputs a given string 10 times
# Each time, the subsequent line should be indented 1 space to the right
# The program should consist of one line only
# Given string: "The Flintstones Rock!"

10.times { |counter| puts (" " * counter) + "The Flintstones Rock!"  }