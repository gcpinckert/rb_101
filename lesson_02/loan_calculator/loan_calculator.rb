def prompt(message)
  puts "==> #{message}"
end

def float?(input_string)
  /\d/.match(input_string) && /^-?\d\.?\d*$/.match(input_string)
end

def valid_loan_amount
  loop do
    # Get input from user: loan amount
    prompt("What is the loan amount?")
    loan_amount = gets.chomp

    # Validate input: Valid floats between 1 and 1,000,000 inclusive
    if  float?(loan_amount) &&
        (loan_amount.to_f > 0) &&
        (loan_amount.to_f <= 1000000)
      return loan_amount.to_f
    else
      prompt("I'm sorry, that's not a valid amount. Please enter a number "\
              "between 1 and 1,000,000.")
    end
  end
end

def valid_annual_interest
  loop do
    # Get input from user: APR
    prompt("What is the APR?")
    annual_interest = gets.chomp

    # Validate input: Valid floats between 0 and 99 inclusive
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
    # Get input from user: loan duration (years)
    prompt("How many years is the duration of your loan?")
    loan_years = gets.chomp

    # Validate input: Valid integers between 1 and 30 inclusive
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

# Display welcome message
prompt("Hi! Welcome to the Loan Calculator!")

# While user wants to keep calculating
loop do
  loan_amount = valid_loan_amount
  annual_interest = valid_annual_interest
  loan_years = valid_loan_years

  monthly_interest = calc_monthly_interest(annual_interest)
  loan_months = calc_loan_months(loan_years)
  monthly_payment = calc_monthly_payment  loan_amount,
                                          monthly_interest,
                                          loan_months
  total_payment = calc_total_payment(monthly_payment, loan_months)
  total_interest = calc_total_interest(total_payment, loan_amount)

  # Display results
  prompt("Your monthly payment is #{monthly_payment.round(2)}")
  prompt("Your total payment is #{total_payment.round(2)} for a period of " \
          "#{loan_months} months.")
  prompt("Your total interest will be #{total_interest.round(2)}")

  # Ask user if they want to go again?
  break if calc_again? == false
end

# Display goodbye message
prompt("Thank you for using the Loan Calculator! Goodbye!")
