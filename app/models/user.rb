class User < ActiveRecord::Base
  has_many :consults
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  before_create :create_remember_token
  validates :password, length: { minimum: 6 }, allow_nil: true
  # before_save { self.email = email.downcase }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
