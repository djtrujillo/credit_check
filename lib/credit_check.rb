class CreditCheck

  def initialize(card_number_string)
    @valid = false
    @card_number_string = card_number_string
    @card_number
    @doubled_card_number
    @final_card_number
    @results_summed
    @card_type = "other"
  end

  def account_identifier                                            # account_identifier method returns array of integers
    card_number_array = @card_number_string.split("")
    @card_number = card_number_array.map do |x|
      x.to_i
    end
    return @card_number
  end

  def two_times_every_other_digit                                   # 2x every_other_digit method returns array of integers with every other element doubled
    account_identifier
    card_type_checker
    if @card_type == "amex"                                         # if card is an amex card, every odd index is doubled
      @doubled_card_number = @card_number.map.with_index do |x, i|  # iterate through card_number
        if i % 2 != 0                                               # if the index of the iteration is divisible by 2
          x * 2                                                     # double the value of the element
        else
          x
        end
      end
    else                                                            # else the card is not amex and will double every even index
      @doubled_card_number = @card_number.map.with_index do |x, i|  # iterate through card_number
        if i % 2 == 0                                               # if the index of the iteration is divisible by 2
          x * 2                                                     # double the value of the element
        else
          x
        end
      end
    end
    return @doubled_card_number
  end

  def summed_digits_over_10                                         # summed_digits_over_10 method returns array of integers; with integers greater than 10, add digits together
    two_times_every_other_digit
    @final_card_number = @doubled_card_number.map do |x|            # iterate over doubled_card_number
      if x >= 10                                                    # find elements greater than 10
        y = x.to_s.split('').map do |z|                             # split the digits
          z.to_i
        end
        y.inject(0) do |sum, x|                                     # and add them together
          sum + x
        end
      else
        x
      end
    end
    return @final_card_number
  end

  def results_summed                                                # results_summed method returns an integer of all array elements from summed_digits_over_10 method
    summed_digits_over_10
    @results_summed = @final_card_number.inject(0) do |sum, x|
      sum + x
    end
    return @results_summed
  end

  def divisible_by_ten                                              # divisible_by_ten method returns a boolean value testing whether results_summed method integer is divisble by ten
    results_summed
    return @results_summed % 10 == 0
  end

  def output_method                                                 # output method return a printed statement if card number is valid or not
    if divisible_by_ten == true
      valid = true
      "The number is valid!"
    else
      valid = false
      "The number is invalid!"
    end
  end

  def card_type_checker                                             # card_type_checker method checks if credit card type is an amex or other type of credit card
    account_identifier
    if @card_number.count == 15
      @card_type = "amex"                                           # assigns card_type instance variable to 'amex' or 'other'
    else
      @card_type = "other"
    end
  end
end

# valid Cards
credit_check1_valid = CreditCheck.new("5541808923795240")
credit_check2_valid = CreditCheck.new("4024007136512380")
credit_check3_valid = CreditCheck.new("6011797668867828")

# invalid Cards
credit_check1_invalid = CreditCheck.new("5541801923795240")
credit_check2_invalid = CreditCheck.new("4024007106512380")
credit_check3_invalid = CreditCheck.new("6011797668868728")


# invalid AMEX Card
credit_checkAMEX_invalid = CreditCheck.new("342801633855673")

# valid AMEX Card
credit_checkAMEX_valid = CreditCheck.new("342804633855673")

# outputs

#valid Cards

puts credit_check1_valid.output_method
puts credit_check2_valid.output_method
puts credit_check3_valid.output_method

# invalid Cards
credit_check1_invalid.output_method
credit_check2_invalid.output_method
credit_check3_invalid.output_method


# invalid AMEX Card
credit_checkAMEX_invalid.output_method

# valid AMEX Card
credit_checkAMEX_valid.output_method
