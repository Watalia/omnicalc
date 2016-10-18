
class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # This is the code to count character with spaces

    @character_count_with_spaces = @text.length

    i=0
    space_counter=0
    while i != @text.length
      if @text[i] ==" "
      space_counter=space_counter+1
      end
      i=i+1
    end

    @character_count_without_spaces = @text.length - space_counter

    ## This is the code for word count

    @word_count = @text.split.length

    ## This is the code to count for the same word

    special_counter=0
    k=0

    while k!= @text.split.length

      if @special_word.downcase == @text.split[k].downcase
        special_counter=special_counter+1
      end
      k=k+1
    end

    @occurrences = special_counter

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    new_interest_rate = @apr/1200
    months=@years*12
    numerator=new_interest_rate*@principal
    denominator=1-(1+new_interest_rate)**(-months)

    @monthly_payment = numerator/denominator

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================


    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.sort[0]

    @maximum = @numbers.sort[@numbers.length-1]

    @range = @maximum-@minimum

    if @numbers.length.even? == true
      @median = (@numbers.sort[@numbers.length/2-1]+@numbers.sort[@numbers.length/2])/2
          else
      @median = @numbers.sort[((@numbers.length-1)/2)]
    end

    j=0
    sum=0
    while j != @numbers.length
      sum=sum+@numbers[j]
      j=j+1
    end
    @sum = sum

    @mean = @sum/@numbers.length

    ##  Varianza
    l=0
    sum_of_squares=0
    while l != @numbers.length
      sum_of_squares=sum_of_squares+(@numbers[l]-@mean)**2
      l=l+1
    end
    @variance = sum_of_squares/@numbers.length

    @standard_deviation = Math.sqrt(@variance)

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
