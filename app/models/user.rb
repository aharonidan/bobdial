class User < ApplicationRecord
	
  belongs_to :black_horse, class_name: 'Team', optional: true
  belongs_to :grey_horse,  class_name: 'Team', optional: true
  belongs_to :champion,    class_name: 'Team', optional: true

  validate :horses_do_not_change_after_deadline, on: :update

  attr_accessor :remember_token
	before_save { self.email = email.downcase }
	
	validates :name,  presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password

  def horses_do_not_change_after_deadline
    if Game.horses_not_editable? and (black_horse_id_changed? or grey_horse_id_changed? or champion_id_changed? or top_scorer_changed? or after_army_trip_changed?)
      errors.add(:black_horse_id, "Change of horses after deadline not allowed!")
    end
  end


  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
