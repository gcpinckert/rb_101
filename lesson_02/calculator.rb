# ask the user for two numbers:
# ask the user for operation to perform
# perform the operation on the two numbers
# output the result

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number)
  number.to_i.to_s == number
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt "Welcome to Calculator! Enter your name:"

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt "Make sure to use a valid name."
  else
    break
  end
end

prompt "Hi, #{name}!"

loop do
  num1 = '' # initialize outside loop to have outer scope
  loop do
    prompt "What's the first number?"
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt "Invalid number" # error message
    end
  end

  num2 = ''
  loop do
    prompt "What's the second number?"
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt "Invalid number"
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt operator_prompt

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt "Must choose 1, 2, 3, or 4"
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  result =  case operator
            when "1" then num1.to_i + num2.to_i
            when "2" then num1.to_i - num2.to_i
            when "3" then num1.to_i * num2.to_i
            when "4" then num1.to_f / num2.to_f
            end

  prompt "The result is #{result}."

  prompt "Do you want to perform another calculation? (Y to go again)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for using the calculator. Goodbye."
