class User < ApplicationRecord
  has_many :messages
  has_many :channels, through: :messages

  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validate :password_requirements_are_met

  def password_requirements_are_met
    rules = {
      " must contain at least one lowercase letter"  => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one digit"             => /\d+/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/
    }
  
    rules.each do |message, regex|
      errors.add( :password, message ) unless password.match( regex )
    end
  end

  # Hide password from results
  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end

end
