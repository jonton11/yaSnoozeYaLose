class User < ActiveRecord::Base # :nodoc:
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  has_many :user_challenges, dependent: :destroy
  has_many :users_challenges, through: :user_challenges, source: :challenge

  has_many :team_users, dependent: :destroy
  has_many :teams_users, through: :team_users, source: :team

  def full_name
    "#{first_name} #{last_name}"
  end
end
