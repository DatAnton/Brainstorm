class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :problem
      t.integer :time
      t.boolean :completed
      t.string :mode

      t.timestamps
    end
  end
end
