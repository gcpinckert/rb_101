def prompt(message)
  puts "==> #{message}"
end

# Display welcome message
prompt("Hi! Welcome to the Loan Calculator!")

# While user wants to keep calculating
loop do
  # Get input from user: loan amount
  prompt("What is the loan amount?")
  loan_amount = gets.chomp
    # Validate input: Valid floats between 1 and 1,000,000 inclusive
  loan_amount = loan_amount.to_f

  # Get input from user: APR
  prompt("What is the APR?")
  annual_interest = gets.chomp
    # Validate input: Valid floats between 0 and 100 inclusive
  annual_interest = annual_interest.to_f / 100

  # Get input from user: loan duration (years)
  prompt("What is the duration of the loan in years?")
  loan_years = gets.chomp
    # Validate input: Valid integers between 1 and 30 inclusive
  loan_years = loan_years.to_i

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