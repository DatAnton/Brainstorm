class CreateExtraTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :extra_times do |t|
      t.integer :time
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
