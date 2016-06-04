class Challenge < ActiveRecord::Base # :nodoc:
  include AASM
  belongs_to :team

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  # validates :reward, presence: true

  has_many :user_challenges, dependent: :destroy
  has_many :users, through: :user_challenges

  aasm whiny_transition: false do
    state :request, initial: true
    state :accepted
    state :rejected
    state :completed

    event :accept do
      transitions from: :draft, to: :accepted
    end
    event :reject do
      transitions from: :draft, to: :rejected
    end
    event :complete do
      transitions from: :accepted, to: :completed
    end
  end
end
