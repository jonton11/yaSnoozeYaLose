class ChallengeAction < ActiveRecord::Base # :nodoc:
  belongs_to :challenge
  belongs_to :user

  validates :challenge_id, uniqueness: { scope: :user_id }
  validates :streak_count, presence: true
end
