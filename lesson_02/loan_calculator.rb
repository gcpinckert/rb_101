# Output methods

def prompt(message)
  puts "==> #{message}"
end

def render_ascii_art(filename)
  File.foreach(filename) { |line| puts line }
end

def display_welcome
  render_ascii_art("banner_art.txt")
  prompt "Hi! Welcome to the Loan Calculator!"
end

def display_goodbye
  prompt "Thank you for using the Loan Calculator! Goodbye!"
end

def display_monthly_payment(monthly_payment)
  prompt("Your monthly payment is: $#{format('%.2f', monthly_payment)}")
end

def display_total_payment(total_payment, loan_months)
  prompt("Your total payment is $#{format('%.2f', total_payment)} for a " \
          "period of #{loan_months} months.")
end

def display_total_interest(total_interest)
  prompt("Your total interest will be: $#{format('%.2f', total_interest)}")
end

# Input and input validation methods:

def float?(input_string)
  /\d/.match(input_string) && /^-?\d\.?\d*$/.match(input_string)
end

def valid_loan_amount
  loop do
    prompt("What is the loan amount?")
    loan_amount = gets.chomp

    if  float?(loan_amount) &&
        (loan_amount.to_f > 0) &&
        (loan_amount.to_f <= 2000000)
      return loan_amount.to_f
    else
      prompt("I'm sorry, that's not a valid amount. Please enter a number " \
              "between 1 and 2,000,000.")
    end
  end
end

def valid_annual_interest
  loop do
    prompt("What is the Annual Percentage Rate (APR?)")
    annual_interest = gets.chomp

    if  float?(annual_interest) &&
        (annual_interest.to_f >= 0) &&
        (annual_interest.to_f < 100)
      return annual_interest.to_f / 100
    else
      prompt("I'm sorry that's not a valid APR. Please enter a number " \
              "between 0 and 99.")
    end
  end
end

def valid_loan_years
  loop do
    prompt("How many years is the duration of your loan?")
    loan_years = gets.chomp

    if  (loan_years.to_i.to_s == loan_years) &&
        (loan_years.to_i > 0) &&
        (loan_years.to_i < 31)
      return loan_years.to_i
    else
      prompt("I'm sorry that's not a valid duration. Please enter a whole " \
              "number between 1 and 30.")
    end
  end
end

# Calculation methods:

def calc_monthly_interest(annual_interest)
  annual_interest / 12
end

def calc_loan_months(loan_years)
  loan_years * 12
end

def calc_monthly_payment(loan_amount, monthly_interest, loan_months)
  if monthly_interest == 0
    monthly_payment = loan_amount / loan_months
  else
    monthly_payment = loan_amount * (monthly_interest / (1 -
                      (1 + monthly_interest)**(-loan_months)))
  end
  monthly_payment
end

def calc_total_payment(monthly_payment, loan_months)
  monthly_payment * loan_months
end

def calc_total_interest(total_payment, loan_amount)
  total_payment - loan_amount
end

# Check if the user wants to go again

def calc_again?
  loop do
    prompt("Would you like to make another calculation? (Y or N)")
    answer = gets.chomp.downcase
    if answer == 'y'
      return true
    elsif answer == 'n'
      return false
    else
      prompt("I'm sorry, I don't understand. Please enter 'Y' or 'N'.")
    end
  end
end

# Clear screen before and between calculations
def clear_screen
  system('clear') || system('cls')
end

# Main program
clear_screen

display_welcome

loop do
  loan_amount = valid_loan_amount
  annual_interest = valid_annual_interest
  loan_years = valid_loan_years

  clear_screen

  monthly_interest = calc_monthly_interest(annual_interest)
  loan_months = calc_loan_months(loan_years)
  monthly_payment = calc_monthly_payment  loan_amount,
                                          monthly_interest,
                                          loan_months
  total_payment = calc_total_payment(monthly_payment, loan_months)
  total_interest = calc_total_interest(total_payment, loan_amount)

  display_monthly_payment(monthly_payment)
  display_total_payment(total_payment, loan_months)
  display_total_interest(total_interest)

  break unless calc_again?
  clear_screen
end

display_goodbye
