class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :addresses

  def self.map_all
    users = all
    users.map do |user|
      {
        id: user.id,
        name: user.name,
        email: user.email,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end
  end

  def generate_token(password = '', refresh: false)
    return unless authenticate(password) || refresh

    self.token = SecureRandom.urlsafe_base64(16, "user_id: #{id}")
    self.refresh_token = SecureRandom.urlsafe_base64(16, "user_id: #{id} refresh_token")
    self.token_expiration_date = Time.now + 1.hour
    save
  end

  def map_tokens
    {
      token:,
      refresh_token:,
      token_expiration_date:
    }
  end
end
