class ChallengeAction < ActiveRecord::Base # :nodoc:
  after_initialize :set_total_streak

  belongs_to :challenge
  belongs_to :user

  has_many :streak_events, dependent: :destroy

  validates :challenge_id, uniqueness: { scope: :user_id }
  validates :streak_count, presence: true

  def set_total_streak
    self.total_streak ||= streak_count
  end
end
