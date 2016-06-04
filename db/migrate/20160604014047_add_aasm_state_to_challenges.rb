class AddAasmStateToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :aasm_state, :string
  end
end
