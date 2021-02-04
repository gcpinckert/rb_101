# Display welcome message
# While user wants to keep calculating
  # Get input from user: loan amount
    # Validate input: Valid floats between 1 and 1,000,000 inclusive
  # Get input from user: APR
    # Validate input: Valid floats between 0 and 100 inclusive
  # Get input from user: loan duration (years)
    # Validate input: Valid integers between 1 and 30 inclusive
  # Calculate monthly interest rate
    # Annual interest rate / 12 
  # Calculate loan duration in months
    # loan duration in years * 12
  # Calculate monthly payment
    # monthly_payment = 
    # months_duration * (monthly_rate / (1 - (1 + monthly rate)**(-duration)))
  # Display results
    # Print to console: monthly payment
    # Print to console: total payment
      # total payment = monthly payment * duration in months
    # Print to console: total interest
      # total interest = monthly rate * duration in months
  # Ask user if they want to go again?
    # Validate input: 'y' or 'n'
    # If yes: 
      # Go back to top
    # If no: break loop
# Display goodbye message