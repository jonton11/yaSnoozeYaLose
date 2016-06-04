class CreateUserChallenge < ActiveRecord::Migration # :nodoc:
  def change
    create_table :user_challenges do |t|
      t.references :challenge, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :streak_count, default: 0
      t.boolean :vote, default: false

      t.timestamps null: false
    end
  end
end
