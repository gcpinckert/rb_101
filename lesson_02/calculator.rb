require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(number)
  if number.to_i.to_s == number
    true
  elsif number.to_f.to_s == number
    true
  else
    false
  end
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt "Hi, #{name}!"

loop do
  num1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  num2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt(MESSAGES['invalid_num'])
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
      prompt(MESSAGES['valid_operator'])
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

  prompt(MESSAGES['again'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])
