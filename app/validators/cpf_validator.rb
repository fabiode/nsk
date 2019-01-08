class CpfValidator < ActiveModel::Validator
  def validate(record)
    field = options[:field].present? ? options[:field] : :document

    null_values = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000}

    if !record.send(field).present? || record.send(field).nil?
      record.errors.add(field, :blank)
      return false
    end

    record.send("#{field.to_s}=", record.send(field).gsub(/[^0-9]/,''))
    unless record.send(field).length == 11
      record.errors.add(field, :wrong_format)
      return false
    end

    digit_array = record.send(field).scan /[0-9]/

    if digit_array.length == 11
      unless null_values.member?(digit_array.join)
        digit_array = digit_array.collect{|x| x.to_i}
        sum = compute_digit_array(digit_array)
        result = verify_computation(sum)
        if result == digit_array[9]
          sum = compute_verifier_digit(digit_array)
          result_digit = verify_computation(sum)
          return true if result_digit == digit_array[10]
        end
      end
    end
    record.errors.add(field, :invalid)
  end

  private

  def compute_digit_array(digit_array)
    10*digit_array[0]+9*digit_array[1]+8*digit_array[2]+7*digit_array[3]+6*digit_array[4]+5*digit_array[5]+4*digit_array[6]+3*digit_array[7]+2*digit_array[8]
  end

  def compute_verifier_digit(digit_array)
    digit_array[0]*11+digit_array[1]*10+digit_array[2]*9+digit_array[3]*8+digit_array[4]*7+digit_array[5]*6+digit_array[6]*5+digit_array[7]*4+digit_array[8]*3+digit_array[9]*2
  end

  def verify_computation(sum)
    sum = sum - (11 * (sum/11))
    (sum == 0 || sum == 1) ? 0 : 11 - sum
  end

end
