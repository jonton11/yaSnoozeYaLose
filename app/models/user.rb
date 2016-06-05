class User < ActiveRecord::Base # :nodoc:
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { message: 'That email is taken.'     },
                      presence: { message: 'Please provide an email!' },
                      format: VALID_EMAIL_REGEX

  has_many :challenge_actions, dependent: :destroy
  has_many :users_challenges, through: :challenge_actions, source: :challenge

  has_many :members, dependent: :destroy
  has_many :memberships, through: :members, source: :team

  def full_name
    "#{first_name} #{last_name}"
  end
end
