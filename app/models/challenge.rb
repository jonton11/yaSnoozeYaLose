class Challenge < ActiveRecord::Base # :nodoc:
  belongs_to :team
  # Many-To-Many Associaton with Users
  # A User can have many habits, a Challenge can have many Users through team
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
end
