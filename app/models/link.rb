class Link < ActiveRecord::Base
  include ActiveModel::Validations
  include EncodeBase65
  validates :full_url, presence: true, uniqueness: {case_sensitive: false}, allow_blank: false, url: true
  validates :short_url, presence: true, uniqueness: true
  validates :access_count, presence: true
  # only shrink for valid urls
  before_validation :shrink, except: [:update], if: Proc.new { |link| link.full_url.present? }
  # only downcase if full_url exists
  before_validation Proc.new {|record| record.full_url = record.full_url.downcase unless record.full_url.blank?}
  scope :top_n, ->(n = 100) { order(access_count: :desc, created_at: :asc).limit(n) }


  def self.insensitive_find_or_init(params)
    where(full_url: params[:full_url].downcase).first_or_initialize
  end

  protected

    # create more verbose shrink method
    # over Proc.new for readability
    def shrink
      if new_record?
        if Link.count == 0
          self.short_url = "-"
        else
          last_link = Link.order(:created_at).last
          puts "self"
          p self
          puts "last link"
          p last_link
          self.short_url = last_link.urlsafe_base65(last_link.short_url)
        end
      else
        true
      end
    end

end