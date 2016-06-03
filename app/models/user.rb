class User < ActiveRecord::Base # :nodoc:
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  belongs_to :team

  def full_name
    "#{first_name} #{last_name}"
  end
end
