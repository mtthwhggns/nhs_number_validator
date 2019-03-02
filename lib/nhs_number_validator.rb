class NhsNumberValidator < ActiveModel::EachValidator
  def self.valid?(number)
    if self.format_valid?(number)
      return false if self.same_digit?(number)
      digit_array = number.to_s.split(//)
      if digit_array[9].to_i == check_digit(digit_array)
        true
      else
        false
      end
    else
      false
    end
  end

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || :invalid) unless self.class.valid?(value)
  end

  private

  def self.format_valid?(number)
    !!(/^\d{10}$/.match(number.to_s))
  end

  def self.same_digit?(number)
    !!(/^(\d)\1{9}$/.match(number.to_s))
  end

  def self.check_digit(digit_array)
    result_array = []
    Array(0..8).each do |i|
      result_array << ((11 - (i + 1)) * digit_array[i].to_i)
    end
    if (11 - (result_array.inject(:+) % 11)) == 10
      return false
    else
      return 0 if result_array.inject(:+) % 11 == 0
      return 11 - (result_array.inject(:+) % 11)
    end
  end
end
