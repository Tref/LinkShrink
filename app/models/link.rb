class Link < ActiveRecord::Base
  include ActiveModel::Validations
  validates :full_url, :short_url, presence: true, uniqueness: true
  validates :full_url, url: true
  before_validation :shrink

  private
  
    def shrink
      
    end

end