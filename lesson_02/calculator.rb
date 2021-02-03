LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
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

prompt('welcome')

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt('valid_name')
  else
    break
  end
end

puts "=> Hi, #{name}!"

loop do
  num1 = ''
  loop do
    prompt('first_num')
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt('invalid_num')
    end
  end

  num2 = ''
  loop do
    prompt('second_num')
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt('invalid_num')
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  puts "=> #{operator_prompt}"

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('valid_operator')
    end
  end

  puts "=> #{operation_to_message(operator)} the two numbers..."

  result =  case operator
            when "1" then num1.to_i + num2.to_i
            when "2" then num1.to_i - num2.to_i
            when "3" then num1.to_i * num2.to_i
            when "4" then num1.to_f / num2.to_f
            end

  puts "=> The result is #{result}."

  prompt('again')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('goodbye')
