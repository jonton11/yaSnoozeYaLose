class AddAasmStateToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :aasm_state, :string
  end
end
