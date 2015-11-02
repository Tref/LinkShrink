class Link < ActiveRecord::Base
  include ActiveModel::Validations
  include EncodeBase65
  validates :full_url, presence: true, uniqueness: {case_sensitive: false}, allow_blank: false, url: true
  validates :short_url, presence: true, uniqueness: true
  before_validation :shrink, except: [:update]
  # before_validation Proc.new {|record| record.full_url = record.full_url.downcase  }
  before_validation :downcase_url
  scope :top_n, ->(n = 100) { order(access_count: :desc, created_at: :asc).limit(n) }

  protected

    def shrink
      if new_record?
        if Link.count == 0
          self.short_url = "-"
        else
          last_link = Link.order(:created_at).last
          self.short_url = last_link.urlsafe_base65(last_link.short_url)
        end
      else
        true
      end
    end

    def downcase_url
      self.full_url = self.full_url.downcase
    end


end