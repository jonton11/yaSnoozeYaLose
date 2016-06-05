class Team < ActiveRecord::Base # :nodoc:
  validates :name, presence: { message: 'Your team must have a name!' },
                   uniqueness: { message: 'Team name taken' }

  has_many :challenges, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
