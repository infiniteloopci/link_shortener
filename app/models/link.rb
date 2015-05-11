class Link < ActiveRecord::Base
  before_create :assign_token
  validates :url, presence: true, format: { with: URI.regexp }

  def self.generate_token
    SecureRandom.urlsafe_base64(6)
  end

  def url_error_message
    errors.messages[:url].first
  end

  private

  def assign_token
    begin
      self.token = self.class.generate_token
    end while token_exists?(self.token)
  end

  def token_exists?(token)
    Link.where(token: token).exists?
  end
end
