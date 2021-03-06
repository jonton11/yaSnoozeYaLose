class Challenge < ActiveRecord::Base # :nodoc:
  include AASM
  belongs_to :team

  validates :name, presence: { message: 'Your Challenge must have a name!' }
  validates :description, presence: { message: 'Please describe the Challenge!' }
  validates :start_date, presence: true,
                         date: { after: Proc.new { Date.today },
                                 message: 'Challenges must begin after today!' },
                         on: :create
  validates :team, presence: { message: 'What team is this challenge for?' }
  validates :reward, length: { minimum: 1 }

  has_many :challenge_actions, dependent: :destroy
  has_many :users, through: :challenge_actions

  aasm whiny_transition: false do
    state :request, initial: true
    state :accepted
    state :rejected
    state :completed

    event :accept do
      transitions from: :request, to: :accepted
    end
    event :reject do
      transitions from: :request, to: :rejected
    end
    event :complete do
      transitions from: :accepted, to: :completed
    end
  end
end
