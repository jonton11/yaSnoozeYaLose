class Team < ActiveRecord::Base # :nodoc:
  has_many :users
  validates :name, presence: true
end
