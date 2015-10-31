class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value =~ /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix
      record.errors[attribute] << (options[:message] || "must be a valid URL (eg. http://www.google.com, http://apple.com)")
    end
  end
end