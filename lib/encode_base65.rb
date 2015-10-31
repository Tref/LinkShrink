module EncodeBase65
  Base65_digits = [*("0".."9"), *("a".."z"), *("A".."Z"), "-", "_", "."].sort{|a,b| a <=> b}
  Charset_size = 65

  def urlsafe_base65(base65n)
    size = Base65_digits.size
    decoded = decode(base65n) + 1
    return encode(decoded)
  end

  private

  def encode(number)
    result = ''
    begin
      result << Base65_digits[number % Charset_size]
    end while (number /= Charset_size) > 0
    result.reverse
  end

  def decode(s)
    s.chars.reduce(0) do |n, c|
      n * Charset_size + Base65_digits.index(c)
    end
  end

end