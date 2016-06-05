class Challenge < ActiveRecord::Base # :nodoc:
  include AASM
  belongs_to :team

  validates :name, presence: { message: 'Your Challenge must have a name!' }
  validates :description, presence: { message: 'Please describe the Challenge!' }
  validates :start_date, presence: true
  # validates :wager, presence: true

  has_many :challenge_actions, dependent: :destroy
  has_many :users, through: :challenge_actions

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

  # How can we refactor?
  # def name_error
  #   'Your Challenge must have a name!'
  # end
  #
  # def description_error
  #   'Please describe the Challenge!'
  # end
end
