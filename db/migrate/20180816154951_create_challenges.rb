class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :problem
      t.integer :time
      t.boolean :completed
      t.string :mode
      t.boolean :impact_flag
      t.boolean :cost_flag

      t.timestamps
    end
  end
end
