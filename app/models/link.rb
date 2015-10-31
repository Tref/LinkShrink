module EncodeBase65
  Base65_digits = [*("0".."9"), *("a".."z"), *("A".."Z"), "-", "_", "."].sort{|a,b| a <=> b}

  def generate_urlsafe_base_65(base65n)
    size = Base65_digits.size
    decoded = decode(base65n) + 1
    return encode(decoded)
  end

  private

  def encode(number)
    result = ''
    charset_size = Base65_digits.size

    begin
      result << Base65_digits[number % charset_size]
      puts "result #{number}"
      puts "result: #{result}"
      puts "number / charset_size: #{number / charset_size}"
    end while (number /= charset_size) > 0

    result.reverse
  end

  def decode(s)
    charset_size = Base65_digits.size

    s.chars.reduce(0) do |n, c|
      n * charset_size + Base65_digits.index(c)
    end
  end

end

class Link < ActiveRecord::Base
  include ActiveModel::Validations
  validates :full_url, :short_url, presence: true, uniqueness: true
  validates :full_url, url: true
  before_validation :shrink
  include EncodeBase65

  private

    def shrink
      last_link = Link.order(:created_at).last
      self.short_url = last_link.generate_urlsafe_base_65(last_link.short_url)
    end

end