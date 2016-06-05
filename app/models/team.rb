class Team < ActiveRecord::Base # :nodoc:
  validates :name, presence: { message: 'Your team must have a name!' }

  has_many :challenges, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
