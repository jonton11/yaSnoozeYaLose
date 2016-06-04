class Team < ActiveRecord::Base # :nodoc:
  validates :name, presence: true

  has_many :challenges, dependent: :destroy

  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
end
