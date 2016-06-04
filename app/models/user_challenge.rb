class UserChallenge < ActiveRecord::Base # :nodoc:
  self.table_name = 'user_challenge'

  belongs_to :challenge
  belongs_to :user

  validates :challenge_id, uniqueness: { scope: :user_id }
  validates :streak, presence: true
  validates :vote, presence: true
end
