def prompt(message)
  puts "==> #{message}"
end

def valid_loan_amount
  loop do
    # Get input from user: loan amount
    prompt("What is the loan amount?")
    loan_amount = gets.chomp

    # Validate input: Valid floats between 1 and 1,000,000 inclusive
    unless (loan_amount.to_f.to_s == loan_amount) && (loan_amount.to_f > 0) && (loan_amount.to_f <= 1000000)
      prompt("I'm sorry, that's not a valid amount. Please enter a number between 1 and 1,000,000.")
      next
    else
      return loan_amount.to_f
    end
  end
end

def valid_annual_interest
  loop do
    # Get input from user: APR
    prompt("What is the APR?")
    annual_interest = gets.chomp

    # Validate input: Valid floats between 0 and 99 inclusive
    unless (annual_interest.to_f.to_s == annual_interest) && (annual_interest >= 0) && (annual_interest < 100)
      prompt("I'm sorry that's not a valid APR. Please enter a number between 0 and 99.")
      next
    else
      return annual_interest.to_f / 100
  end
end

def valid_loan_years
  loop do
    # Get input from user: loan duration (years)
    prompt("How many years is the duration of your loan?")
    loan_years = gets.chomp

    # Validate input: Valid integers between 1 and 30 inclusive
    unless (loan_years.to_i.to_s == loan_years) && (loan_years > 0) && (loan_years < 31)
      prompt("I'm sorry that's not a valid duration. Please enter a whole number between 1 and 30.")
    else
      return loan_years.to_i
  end
end

# Display welcome message
prompt("Hi! Welcome to the Loan Calculator!")

# While user wants to keep calculating
loop do
  loan_amount = valid_loan_amount
  annual_interest = valid_annual_interest
  loan_years = valid_loan_years

  # Calculate monthly interest rate
  monthly_interest = annual_interest / 12

  # Calculate loan duration in months
  loan_months = loan_years * 12

  # Calculate monthly payment
  unless monthly_interest == 0
    monthly_payment = loan_amount * (monthly_interest / (1 - (1 + monthly_interest)**(-loan_months)))
  else
    monthly_payment = loan_amount / loan_months
  end
  
  # Display results
  # Print to console: monthly payment
  prompt("Your monthly payment is #{monthly_payment.round(2)}")

  # Print to console: total payment
  total_payment = monthly_payment * loan_months
  prompt("Your total payment is #{total_payment.round(2)} for a period of #{loan_months.round} months.")

  # Print to console: total interest
  total_interest = total_payment - loan_amount
  prompt("Your total interest will be #{total_interest.round(2)}")

  # Ask user if they want to go again?
      # Validate input: 'y' or 'n'
  answer = ''
  until ['y', 'n'].include?(answer)
    prompt("Would you like to perform another calculation? (Y or N)")
    answer = gets.chomp.downcase
  end
  break if answer == 'n'
end

# Display goodbye message
prompt("Thank you for using the Loan Calculator! Goodbye!")